From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Wed, 16 Apr 2008 16:03:34 -0400
Message-ID: <32541b130804161303i74a4dd3bw5ef72105ebf5485b@mail.gmail.com>
References: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Nigel Magnay" <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 22:18:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmDrz-0000nG-H0
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 22:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbYDPUDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 16:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbYDPUDh
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 16:03:37 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:35631 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbYDPUDg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 16:03:36 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2949929fkr.5
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OQdqy9Pc7pmtsOlVLwYdlLuq30sRJJDIlAHDcN7V4g4=;
        b=cHUqyCmh4mluKdIcWpUNIyB8ASV8K3/ICQKaKQ8UBYuILAi9q15/I/k5/uPwPFMVTe/0pQe3TurdtdSPvFgNuduuAsxB6jQQnsPKh1zczKE5TqwKwEN03IsaELrNBbPiRJC9v34cIeUbG4NG/AqRrHPjOdx83vhvdauwRA6FtaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FBBCv1p1mUHWoTyH+Mr8YKoPltpPG+3OJvB9TKP4MQA9jtfnq4snjUQWvtjK44HE5kHzE9RYEgNpBI/wIbyna/CW8GUezL8l4UNe5DXGRIbvU1pGaUvs6oUa5W/HZT4zmMNmbZOcW+bzy29OKYd7XhJqt9+QTm+cXM93B/ZhKb0=
Received: by 10.82.188.15 with SMTP id l15mr657026buf.34.1208376214449;
        Wed, 16 Apr 2008 13:03:34 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 16 Apr 2008 13:03:34 -0700 (PDT)
In-Reply-To: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79738>

On 4/16/08, Nigel Magnay <nigel.magnay@gmail.com> wrote:
>  Why does it think in this instance that there is a change? It's CRLF
>  in the repo, it's CRLF in the working tree, and the checkout in either
>  mode ought to be identical ??

We got quite confused by this here too.  I'm pretty sure git's
autocrlf feature is buggy, as you've noticed.  Combined with that, svn
has its *own* kind of autocrlf feature (svn:eol-style property on each
file) that acts completely differently.

As an added bonus, I don't know if you've run into this yet, but
cygwin's "patch" command seems to unconditionally strip CR from
patches *before* trying to apply them at all, *even if* the target
file is CRLF, so patches just never apply to CRLF files ever.  Ha ha!

I managed to make the two systems stop stomping on each other, in our
case, by using svn:eol-style of "native" (which means when git-svn
checks out the file, it gets only LF, since it seems to always claim
to be Unix) and not using git's autocrlf at all.  However, this isn't
optimal since then Windows git users end up with LF instead of CRLF in
their files, which confuses them.

On the other hand, the conflicts and the random-newline-changing diffs
go away, as svn fixes things up at checkin time no matter how badly
they got mangled by the windows user (most commonly, they run a
program that resaves the whole file as CRLF).

Obviously a working git autocrlf feature would be better, but I
haven't looked into it closely enough to say where the problem
actually lies.

Have fun,

Avery
