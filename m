From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?,.gitacls? etc.
Date: Wed, 5 Sep 2007 01:31:33 -0700
Message-ID: <a1bbc6950709050131g397f1ef0p999681f8d13a8a42@mail.gmail.com>
References: <7vhcmmpxed.fsf@gitster.siamese.dyndns.org>
	 <B4A2AE9980774365B5D14B442A7A22F6@ntdev.corp.microsoft.com>
	 <20070826100647.GH1219@pasky.or.cz>
	 <4C603F7C51884DF8AFAEC3F6E263798D@ntdev.corp.microsoft.com>
	 <a1bbc6950708271327x4dd948d4m8e9e35f757a7d92e@mail.gmail.com>
	 <Pine.LNX.4.64.0708280945350.28586@racer.site>
	 <20070904202326.GC3786@efreet.light.src>
	 <a1bbc6950709050106j137215obd7272b2a77c3b13@mail.gmail.com>
	 <7vk5r5jzpn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jan Hudec" <bulb@ucw.cz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Petr Baudis" <pasky@suse.cz>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 10:31:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISqIW-00005k-0c
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 10:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921AbXIEIbf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 04:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755789AbXIEIbf
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 04:31:35 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:14233 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633AbXIEIbe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 04:31:34 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1394749rvb
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 01:31:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bTlgrYHMmKlSzNnJCdAW69+H95KiTBzVc/5NkRWXbjA+UleDTcixyry6yddfoS/7njsXT/HcLv+Z2ld9OOsTgWOOVh5Tav1IpyYEaK8+o/8DN+TOn7TKBrUiByWHHeP1UxAfVlgfm2vGlAXsKB/Yg9D3uV5PorN86JlE9Q8pJy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PvZdCA2zmsMyxAzesNOk28Ljwt+61GupV4ZFb7BBN+F43pwMpP95GnP+pSH8Swg7tiAFwW3djk4lRc9FzJIY16IzFabn7kPDkUpwOWcNZZH1uKRCYYQcAd7Jv0RxWv6SWN1QfPOKZv1U4QyNMse9NzYPlFdJpYDxXhpWJI5UjeU=
Received: by 10.141.78.14 with SMTP id f14mr2724129rvl.1188981093555;
        Wed, 05 Sep 2007 01:31:33 -0700 (PDT)
Received: by 10.141.2.18 with HTTP; Wed, 5 Sep 2007 01:31:33 -0700 (PDT)
In-Reply-To: <7vk5r5jzpn.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57686>

On 9/5/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Dmitry Kakurin" <dmitry.kakurin@gmail.com> writes:
>
> > I assert that since index does not have .gitattributes the one from
> > local directory should not be used.
> >
> > Think about dedicated build machine scenario: I have a machine that
> > always does sync + build. After every sync the local directory should
> > always be identical to what-was-committed.
>
> Thinking about the reason _why_ .gitattributes may be updated,
> one would notice that it is because somebody did this command
> sequence:
>
>        git checkout            ;# now work tree is clean
>        edit .gitattributes     ;# modify the attributes of a file
>        edit file               ;# edit the file attributes talks about
>        git add file            ;# this can be affected by .gitattributes
>        git add .gitattributes  ;# this is changed in the same commit
>        git commit
>
> Now, should we always take .gitattributes from the index?
No, from couple of my emails back:

> This leads to a simple idea that mostly works:
> 1. when files are moved from index to filesystem, then only .gitattributes in the index is used, if it's not there == no special attributes.
> 2. when files are moved from filesystem to index, then only .gitattributes in filesystem is used, again if it's not there == no special attributes.
>
> Then, in any operation, only one .gitattributes is taken into account.

This is a must-do change (IMHO).

To go one step further (again IMHO) is to eliminate workspace version
of .gitattributes all together:
> We could stop here, but to me this redundancy still has some room for confusion and looks unnecessary.
> Plus there is still room for unintentional abuse (by mistake).
> That's why I think it's a good idea to always have only one .gitattributes (in the index).

-- 
- Dmitry
