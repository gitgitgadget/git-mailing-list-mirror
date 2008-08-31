From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sun, 31 Aug 2008 14:29:28 -0400
Message-ID: <32541b130808311129u79f4179enfabab8f5845ed522@mail.gmail.com>
References: <20080830173947.GF7185@schiele.dyndns.org>
	 <20080830183413.GG7185@schiele.dyndns.org>
	 <20080830183949.GA16415@coredump.intra.peff.net>
	 <200808302237.17017.jnareb@gmail.com>
	 <32541b130808302235g6a23efcfs78efe2ef557cd9c7@mail.gmail.com>
	 <8663phnw3z.fsf@blue.stonehenge.com>
	 <7v63ph40at.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	"Jakub Narebski" <jnareb@gmail.com>, "Jeff King" <peff@peff.net>,
	"Robert Schiele" <rschiele@gmail.com>, git@vger.kernel.org,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 20:31:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZrhc-0000zL-E0
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 20:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338AbYHaSaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 14:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755196AbYHaSaA
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 14:30:00 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:11670 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493AbYHaSaA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 14:30:00 -0400
Received: by yx-out-2324.google.com with SMTP id 8so972310yxm.1
        for <git@vger.kernel.org>; Sun, 31 Aug 2008 11:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=G77WVhQspPEMo/DyMbB9aBa7/cmoXmqm/8CDoC0F4fQ=;
        b=IUvKX/QUIdGzDs6eDF3gQgCr36WyC8WhR+lJiljW0tzeg34woNL0YRrXivx7zEUsdj
         ES4bpwnuh2kGQftSP8ezB6JHUiDFv8ydxPfCFFLnv2m6V4o2RuikybxZ8gUteQvkY8vD
         qX4wPR7dqwldHSeILz6bwAtb/Sf806hx4R5oI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EQhoeAf5bjpRwFizfYOfOOijvaC1gJbC6eZCjfSc/JyC6vtQV6cUQAm896Kln9hKDd
         HNNcf9l7wk6sloppfOWmYrR396byFcVFfUI6NcPSE35RWqb33c4MShDnL7/Vr0QCXRej
         JgAPtXtCdpqdTEk+tVCd9PJqAK0DdJbUWXbrY=
Received: by 10.151.45.6 with SMTP id x6mr1799534ybj.110.1220207398973;
        Sun, 31 Aug 2008 11:29:58 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Sun, 31 Aug 2008 11:29:28 -0700 (PDT)
In-Reply-To: <7v63ph40at.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94498>

On Sun, Aug 31, 2008 at 12:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>
>>>>>>> "Avery" == Avery Pennarun <apenwarr@gmail.com> writes:
>>
>> Avery> Shell quoting is a disaster (including security holes, where relevant)
>> Avery> waiting to happen.  The above is the only sane way to do it, and it
>> Avery> isn't very hard to implement.  (Instead of system() in the subprocess,
>> Avery> you can use exec().)
>>
>> quotemeta() is about regex quoting.  This is not precisely the same as shell
>> quoting, and is both misleading, and potentially broken.
>
> Agreed to, and grateful for, both of your comments.
>
> Do you like the one Jakub quoted from how gitweb does it?  It looks like
> this:
>
>    # quote the given arguments for passing them to the shell
>    # quote_command("command", "arg 1", "arg with ' and ! characters")
>    # => "'command' 'arg 1' 'arg with '\'' and '\!' characters'"
>    # Try to avoid using this function wherever possible.
>    sub quote_command {
>           return join(' ',
>                       map( { my $a = $_; $a =~ s/(['!])/'\\$1'/g; "'$a'" } @_ ));
>    }

No, that's just another feeble attempt at quoting, which may or may
not be correct.  I'm not smart enough to tell.

I have a proper implementation in the 'runlock' script in gitbuilder:

    http://github.com/apenwarr/gitbuilder/tree/master/runlock

In that particular case, I wanted to handle signals carefully, so I
needed the manual fork thing even in perl 5.8.  You can safely remove
the signal handling stuff (and of course the lockfile stuff) if you
just want a minimal safe fork-exec-wait implementation in perl.

Have fun,

Avery
