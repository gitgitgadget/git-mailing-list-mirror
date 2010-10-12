From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] svn-fe: Use the --report-fd feature
Date: Tue, 12 Oct 2010 18:36:12 -0500
Message-ID: <20101012233612.GI15587@burratino>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-8-git-send-email-david.barr@cordelta.com>
 <AANLkTikxsP_DV2Tjwk9vNi1WZFFiFEjQjCjhcbc5FETf@mail.gmail.com>
 <20101012230344.GH15587@burratino>
 <AANLkTikoSedLFD7pnMvzWYLxCTURhc=1h=73s4uj+fcM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 01:39:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5oRX-0000oD-UC
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 01:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207Ab0JLXje convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 19:39:34 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55772 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab0JLXjd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 19:39:33 -0400
Received: by qwa26 with SMTP id 26so705866qwa.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 16:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vFQYkh7XN6bj7ZvkbC86YFO8d4EsqxbBDCEuhA41bzk=;
        b=uhHJWN3rcoytWGu6Y7AkcnAbUxCxsisXwQHDGa6Oyn8s7EubpBJ/IhMrj/NFRJdjbi
         sgNnYx1Z1J/qqKTZRXUUL5gjgrDSTsMK78GSyrWl9Im/wFR3CtuFZakrTdHwvOhEBG0l
         xojzlvMYWiiQ5ogbNVIiV57NLnMB/Z/qHs62Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=TI7x3o/g6PeQL6dd6+M6R4VWYZB6fr+h9Xgu6cmtJvhZtoyAKPhrMQi1WSKpOPq04u
         Ma97yF9weQacV/TsFWgpeNWF6nY+VCqh9D4fkDhvdOvQXV+8txn/eUg7njw61DDw2Xmb
         uDH8CO0o65nj6+1ToY/rpX4ccUkukwdDhfVyE=
Received: by 10.229.79.75 with SMTP id o11mr6907980qck.96.1286926772573;
        Tue, 12 Oct 2010 16:39:32 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id t17sm5824230qcp.14.2010.10.12.16.39.31
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 16:39:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikoSedLFD7pnMvzWYLxCTURhc=1h=73s4uj+fcM@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158899>

Sverre Rabbelier wrote:
> On Wed, Oct 13, 2010 at 01:03, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> The caller has to take care of backflow of data. =C2=A0Even if the
>> "cat" command were never used, at least 3>/dev/null would be
>> necessary to avoid fast-import waiting forever for the frontend
>> to read from it.
>
> Why is that? If we disable the auto-printing of sha's

Right, if we disable the auto-printing of sha's then that aspect goes
away.

>> One way to work around this would be for svn-fe to launch fast-impor=
t
>> itself.
>
> What would the pipeline look like then? In particular for git-remote-=
svn?

Probably something like:

svnrdump dump uri -r <lower>:<upper> |
svn-fe --fastimport=3D'svn-filter-root ...'

Doesn't the transport helper take care of launching fast-import
itself?
