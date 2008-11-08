From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] Introduce rename factorization in diffcore.
Date: Sat, 8 Nov 2008 11:30:37 +0700
Message-ID: <fcaeb9bf0811072030u272a6732g2450e1854b96ca18@mail.gmail.com>
References: <20081030220532.3325.54457.stgit@gandelf.nowhere.earth>
	 <20081030221645.3325.78288.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 05:32:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyfUK-0002mH-PH
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 05:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbYKHEak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 23:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbYKHEak
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 23:30:40 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:43411 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbYKHEaj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 23:30:39 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1299170fgg.17
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 20:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FuKSiRNWD1VrQ68C7PrVBIPHk87zWylnuo13G7NDGag=;
        b=VZDVyNwHixuw6C6W/wc81xQjzp2b7Vu/3HtEv4V5IUa4+Tt3opDq2Xmyw+tkbwU4ys
         h3VOERQbo9Ev/mGnpQnJQkni15af7z26MLBStdKxAr2t1Dtd+RlnG5wmb0y0YxBAraF2
         O+BBRDf2r7fbCCQiFP1rnfOZm8YMkZPceEoX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=RQ5le/oKIp8HB33SDakpzNa3YYNFQkIxytvGx2DZLLMPYdkuq+BDvVpw5OZsNItemU
         Y3h9oSIkAMsbYlkefHx/GmEAWvlv3yYBBdsW5/HY2IKTPa35F+qTe3eVNOk0S5SQR+oG
         bgkKl4Q4e4kBLuHVwdJo1AUGcP5Z3p6QCP8jY=
Received: by 10.86.100.19 with SMTP id x19mr451008fgb.29.1226118638053;
        Fri, 07 Nov 2008 20:30:38 -0800 (PST)
Received: by 10.86.27.20 with HTTP; Fri, 7 Nov 2008 20:30:37 -0800 (PST)
In-Reply-To: <20081030221645.3325.78288.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100374>

On 10/31/08, Yann Dirson <ydirson@altern.org> wrote:
>  -               else if (detect_rename == DIFF_DETECT_COPY) {
>  -                       /*
>  -                        * Increment the "rename_used" score by
>  -                        * one, to indicate ourselves as a user.
>  -                        */
>  -                       p->one->rename_used++;
>  -                       register_rename_src(p->one, p->score);
>  +               else {
>  +                       if (detect_rename == DIFF_DETECT_COPY) {
>  +                               /*
>  +                                * Increment the "rename_used" score by
>  +                                * one, to indicate ourselves as a user.
>  +                                */
>  +                               p->one->rename_used++;
>  +                               register_rename_src(p->one, p->score);
>  +                       }
>  +                       if (DIFF_OPT_TST(options, FACTORIZE_RENAMES)) {
>  +                               /* similarly, rename factorization needs to
>  +                                * see all files from second tree
>  +                                */
>  +                               //p->two->rename_used++; // FIXME: would we need that ?
>  +                               locate_rename_dst(p->two, 1);
>  +                       }
>                 }
>         }

Hmm.. how about turn on a special flag for these rename_dst items?
Otherwise --group-renames and --find-copies-harder combination would
become hell: you have to compare all src with all dst. It could exceed
rename_limit, therefore no rename detection will be done.
-- 
Duy
