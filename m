From: "Dave Hanson" <drh@drhanson.net>
Subject: Re: git-svn crashes with svn 1.4.4
Date: Fri, 15 Jun 2007 14:49:20 -0700
Message-ID: <9fb1551c0706151449q4baddb86tc0f2e7f1a929c811@mail.gmail.com>
References: <9fb1551c0706151315u221feed1se61cc7689ba1f7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 23:49:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzJfi-0005DX-02
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 23:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756722AbXFOVtX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 17:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754310AbXFOVtW
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 17:49:22 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:29707 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756258AbXFOVtV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 17:49:21 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1084620nzf
        for <git@vger.kernel.org>; Fri, 15 Jun 2007 14:49:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Mkmrj6nLkOafqhte3yFZPBLffUiZB0lE7MIJ9R/dkFrzvktNN8aTypfIgogwqK3p9NwkIeyNbGPPjG539FUDD2JFOEyRS8COD21VtOl33Ml7VUc76h6jma5ysJVPa4tdBJY/VVFt4a65GP/IqHGHEFEPXAKXMTTCd/tdej2C+ag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=DXei5+Bu8BY3HgBUSjCmytthMvqOY6KbEaH9j4Fd/jc+orD8WjdO7xXtbgcD/knC0gL2NTtHGtnmiUxZRSC/SoO/OQHD+yU6GImmHCs4JsZ9ywLF0xfanDGMB50ofNY1/6LqX1H2zczFLOKC6sEskYeo3SFV3z58q3nnmpSfNxU=
Received: by 10.142.109.16 with SMTP id h16mr177660wfc.1181944160727;
        Fri, 15 Jun 2007 14:49:20 -0700 (PDT)
Received: by 10.143.10.21 with HTTP; Fri, 15 Jun 2007 14:49:20 -0700 (PDT)
In-Reply-To: <9fb1551c0706151315u221feed1se61cc7689ba1f7d@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: b7f672a5c5f8a5ad
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50278>

On 6/15/07, Dave Hanson <drh@drhanson.net> wrote:
> I just installed Subversion 1.4.4 on my Intel Mac Pro from
> http://downloads.open.collab.net/binaries.html. After doing so,
> git-svn dies with a bus error, in a perl library, I believe.

Fixed. Turns out I had older--and now incompatible--svn Perl bindings in

/Library/Perl/5.8.6/darwin-thread-multi-2level/{SVN,auto}

The newest bindings are in

/usr/local/lib/svn-perl/{SVN,auto}/

Even running perl -e "use SVN::Core" crashed with a bus error. Adding
/usr/local/lib/svn-perl to the environment variable PERL5LIB fixes
these problems.

I removed /Library/.../{SVN,auto}. Interestingly, perl -e "use
SVN::Core" then fails with a reasonable diagnostic. Next, I did

sudo cp -rp /usr/local/lib/svn-perl/* \
   /Library/Perl/5.8.6/darwin-thread-multi-2level

which obviates the need to set PERL5LIB. I'm sure there's a way to
configure perl to add /usr/local/lib/svn-perl to PERL5LIB. Even so,
the old, incompatible bindings must be removed.

Pardon the false alarm,
dave h
