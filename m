From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: Git Config Question
Date: Mon, 2 Aug 2010 21:13:30 +0200
Message-ID: <2BD00E81-C9E9-4733-8F21-F55B4D6D961D@gmail.com>
References: <AANLkTin8tW_qiRO57F-yjYHzhUkrZbO1g3L_hmesenGL@mail.gmail.com> <20100719055909.GA16276@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.orgList List" <git@vger.kernel.org>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Shilpa Kulkarni <syk@payasonline.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 21:13:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og0SE-00070b-F1
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 21:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161Ab0HBTNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 15:13:37 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46553 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab0HBTNg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 15:13:36 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so1426901ewy.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=moJKTZ4+Q1F+DxhgepR6JyNx7bz2hR6sBzAVDSknFQM=;
        b=PoaapzwAl2YY/mBhNetTf4Z/gdPKKW7h/0PWo2tY9LybU7HXLbMRfP5MEocp/wOU0H
         7gSDXOaauiK9B/K43+TvRhyemPTbRPZAab7yXSIaxas818b7VaOl5uQxPbsxC1V+UziB
         mFZj7ZGAhLE+W+P8XeEbPkZAc87IgvWfBBBSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=VRHbEiLZxoq+xwDSbwjn+gZjsaWFirzQRjOLdJo45aOOMTebHmQNkphNTxI2bZxBDX
         gUzh2HHfwrp0dSGFWOSme6O7AKncTixI7sgSOwDtt+VDN3HOxe89ZhiGzFewiE2CuFMu
         iwSH3DwrbJEOO7RKoyXEXpvfhsdQ43/oXssWA=
Received: by 10.213.19.82 with SMTP id z18mr4534836eba.74.1280776415903;
        Mon, 02 Aug 2010 12:13:35 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id a48sm9342985eei.7.2010.08.02.12.13.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 12:13:33 -0700 (PDT)
In-Reply-To: <20100719055909.GA16276@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152440>

On 19. juli 2010, at 07.59, Jonathan Nieder wrote:

> Shilpa Kulkarni wrote:
> 
>> 2. Person Y checks in code (commit & push). Checks in file a, b.
>> 
>> 3. Person X does a 'git pull origin master'.
>> 
>> Pull succeeds - however
>> 'git status' shows file a, b as modified even though person X has done
>> nothing with these files.

Sorry for the late reply.

The problem is that the files are checked in to the repository with CRLFs intact, but then checked out in a repository that has autocrlf enabled.  The result is that git wants to convert the files to LF, and shows them as modified even though no actual changes have been made.

This no longer happens with git 1.7.2: autocrlf will not convert files that contain CRLFs in the repository.  To enable forced conversion of text files containing CRLF with 1.7.2 or later, add this line to .gitattributes:

	*	text=auto

Files that need conversion (a and b in your example) should be checked in in the same commit as the change to .gitattributes.  gitattributes(5) has a recipe for making sure all files are converted.

Eyvind
