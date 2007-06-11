From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Mon, 11 Jun 2007 12:47:43 +0200
Message-ID: <8c5c35580706110347u55a944ds86f06dabce9e6435@mail.gmail.com>
References: <1181425132239-git-send-email-hjemli@gmail.com>
	 <11814251322779-git-send-email-hjemli@gmail.com>
	 <20070610002802.GD31707@planck.djpig.de>
	 <8c5c35580706100158n7dabfce4y5f79f8943d8abb87@mail.gmail.com>
	 <20070610121202.GD955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706100530g256de4a4yb12f4647dae06500@mail.gmail.com>
	 <7vzm377cjk.fsf@assigned-by-dhcp.cox.net>
	 <8c5c35580706101414r72c45e84q2b81083f8f88ec40@mail.gmail.com>
	 <20070611083406.GH955MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Frank Lichtenheld" <frank@lichtenheld.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Jun 11 12:47:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxhRD-0004Vt-1K
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 12:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758875AbXFKKrq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 06:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755716AbXFKKrq
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 06:47:46 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:60732 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757988AbXFKKrp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 06:47:45 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1210397nzf
        for <git@vger.kernel.org>; Mon, 11 Jun 2007 03:47:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BVP11utY/Xm3MkNTY8gxgxgsRCiPQ7SLo2C2iiOI9r9YHpNz/TM/7ojFTgJw7XRKakBqQ7vAaViPJKIuyG23KbtSfAtf/5P3lp/VXmciIG7C4oZwzCg+FXNWl5sInDcBMxjOHmVMMTzLMSC0keH2dHfwXryg2F+R7ZMlbWQaf34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=My6PIqYapoS0Dil8LmqBV5PDPttEluZbCUN0Cj8J0EPpb5JhW8+PtNtoUwC6yzyQpp8ozUOI8ZwHAXcVsiFqq8426zlU1yf7kYwlDrjImPoeaK4LRVTg6l2ZpuM95eGW65+A5C9/AZSlgFQoSqtQp3T2TfHJz5fpFJ3CJfYoutc=
Received: by 10.114.166.1 with SMTP id o1mr5395062wae.1181558863738;
        Mon, 11 Jun 2007 03:47:43 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Mon, 11 Jun 2007 03:47:43 -0700 (PDT)
In-Reply-To: <20070611083406.GH955MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49844>

On 6/11/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Sun, Jun 10, 2007 at 11:14:27PM +0200, Lars Hjemli wrote:
> > And I'll drop the "unless otherwise
> > noted, name=path" behaviour. If we later decide it would be useful we
> > can always "re-add" it.
>
> So every (sub)module subsection will have to have a path element?

Yes

> Why?

It addresses Junio's concern about ambiguity and confusion. And it
felt like the 'safe choice', i.e. starting out with a strict rule and
possibly loosen it later on is a lot easier than starting loose and
then trying to make it stricter.

Btw: adding support for the optional path specification on top of my
latest patch-series is trivial:

diff --git a/git-submodule.sh b/git-submodule.sh
index 89a3885..297272b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -34,8 +34,7 @@ module_name()
 {
        name=$(GIT_CONFIG=.gitmodules git-config --get-regexp
'^submodule\..*\.path$' "$1" |
        sed -nre 's/^submodule\.(.+)\.path .+$/\1/p')
-       test -z "$name" &&
-       die "No submodule mapping found in .gitmodules for path '$path'"
+       test -z "$name" && name="$path"
        echo "$name"
 }

--
larsh
