From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Thu, 9 Dec 2010 12:38:14 +0100
Message-ID: <201012091238.15685.jnareb@gmail.com>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com> <20101209015926.GA31119@burratino> <7vsjy7h3db.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Kevin Ballard <kevin@sb.org>,
	Yann Dirson <dirson@bertin.fr>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 12:38:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQepW-000762-Ec
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 12:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521Ab0LILi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 06:38:29 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:51392 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384Ab0LILi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 06:38:28 -0500
Received: by fxm18 with SMTP id 18so2244079fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 03:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=umbxWvnvx+ElGncxQ8v3kCaHzo4IlIPiVvJHzE8opFw=;
        b=IO0s8b6VqoaNnsaGw/CeOn5YjyYWLwntY+o4scqWdnRShzmp9gCpcQQxMubiIz/roq
         IAwP8niXUQIZr7BEKc95txZwTH/IgTiEXRZ5JoJ6YzIEi6IP0vsb5NHbByJVTmYmLLHe
         DlcZjC2ns9BjGjdNtfryKOVuP2Q01/i7z5Egs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fHi4mQnt6c8LUtqr65G5XpXyMO3Jeh8WkWH9djj4LCJr+8/HOqubmPpdmc/INwmT0L
         pYDd4E+5plnVZEY8q+3W0wBAJ8rIIjWXfI8XMYQ57tKycimy7KqXd+qu69yr+F1wOf9Z
         ttBrd1Vkjd2aMGvfhrV5abdUsM5ovXzpncgrs=
Received: by 10.223.123.209 with SMTP id q17mr4020135far.126.1291894706943;
        Thu, 09 Dec 2010 03:38:26 -0800 (PST)
Received: from [192.168.1.13] (abvw115.neoplus.adsl.tpnet.pl [83.8.220.115])
        by mx.google.com with ESMTPS id y1sm485281fak.39.2010.12.09.03.38.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 03:38:25 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vsjy7h3db.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163275>

On Thu, 9 Dec 2010, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Jakub Narebski wrote:
>>
>>> You would need HEAD{^{/foo}^@}x3, or use special rule that HEAD^{/foo}x2
>>> means really HEAD^{/foo}^@^{/foo}, with ^@ used to join them.
>>
>> That said, does ^2x500 really do something meaningful that a person
>> would ever need?  I like the
>>
>> 	^{:nth(3)/foo}
>>
>> syntax because perl6 supports m:nth(3)/foo/, suggesting a menu of
>> already-defined modifiers to implement when they prove useful,...
> 
> Can you explain what the colon in "$commit^{:nth(3)/foo}" is doing?  
> 
> Are we declaring anything that begins with ':' is a magic inside ^{...}
> construct?

The idea is to follow Perl 6 rule of combining modifiers "Every modifier
must start with its own colon."
  http://perlcabal.org/syn/S05.html#Modifiers

This allow for easy combining modifiers without introducing special rules,
for example ^{:g:i/foo} would return all matches (:g == :global) instead
of only the first, ignoring case (:i == :ignorecase).
 
> I do not think nth($n) without specifying where to start (iow, what the
> current ":/foo" implementation does but with "three levels deep") makes
> any sense, but because the main point of your argument is that we can have
> modifies other than nth($n) that may make sense in such a context, I would
> want to make sure anything we come up with is extensible to that syntax.

Hmmm... I haven't thought about it.  I guess that ^{:nth(N)/foo} should
return Nth element in the list that ^{:g/foo} / --grep=foo would return.

This way one could use

  $ git log pu@{1}..pu --merges --grep="Merge branch 'nd/"

to find all new Nguyen contributions in 'pu', and

  $ git log pu..pu^{:2nd/Merge branch 'nd/}^2

to view 2nd (2nd == nth(2)) such branch on the list.

> 
> On the "starting from any ref" front, I think "!" (as in ":/!some magic")
> was the introducer we reserved for such a magic some time ago, so perhaps
> on the "starting from this commit" side, "^{!magic/foo}" may be more
> appropriate?

I'd like to deprecate ":/foo" in favor of "--all ^{/foo}", or even special
case it to "^{/foo}" (if not attached to ref, ^{(:<modifier>)*/<regexp>}
acts on positive revs replacing them).

But ^{/foo} might be overengineered...
-- 
Jakub Narebski
Poland
