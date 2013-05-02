From: Ilya Basin <basinilya@gmail.com>
Subject: Re: git-svn: problem with svn cp trunk/subdir tags/subdir_1.0
Date: Thu, 2 May 2013 22:19:26 +0400
Message-ID: <603835689.20130502221926@gmail.com>
References: <1826029946.20130429164645@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 02 20:21:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXy82-0007mF-5l
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 20:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760668Ab3EBSVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 14:21:09 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:61221 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab3EBSVH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 14:21:07 -0400
Received: by mail-lb0-f170.google.com with SMTP id t11so832309lbd.1
        for <git@vger.kernel.org>; Thu, 02 May 2013 11:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=z4laW2VmGCXAbeo2EnYbB7aazG0n1h0OrpiHD6dmyh8=;
        b=O6Zdk/MXpGlYNcb5RjenmxJ5RFkz91MRClbjcL9KQTaTbgebmMqXEC0O20z/yoJZgs
         StowpnMbmp7wbFj0iw8ar686V19SoM+VADHnJeQ/KCOFPNL0JYl7bLqABOWV/kFh3wXh
         3i+G7DRM2cNA5SiZpSbogSHqd7yAG/l6/ePfddSryZJCLTF9RlxpEJRMLan/uJSD/FfA
         Ng32i0qIU8LCKAD5Ca7A8IX59nLDwaokNccDFx2+d3DAYN6qDRyKSXYmzBxoUhhhEzCW
         u3f1FNEBcM8SCjyiZ4JU8g/XipxmndEe8tJrpx56wakbrxodpFHaHvu4Rfcq9xvIZZby
         REbw==
X-Received: by 10.152.28.230 with SMTP id e6mr2940042lah.57.1367518866206;
        Thu, 02 May 2013 11:21:06 -0700 (PDT)
Received: from [192.168.0.78] (92-100-239-74.dynamic.avangarddsl.ru. [92.100.239.74])
        by mx.google.com with ESMTPSA id t20sm3107084lbi.5.2013.05.02.11.21.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 11:21:04 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <1826029946.20130429164645@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223244>

IB> When creating a tag or branch from a subdir, a disjoint branch
IB> is created. Then git-svn re-imports the commits using this dir as
IB> strip path.

IB> Why? I would instead keep the current commit as parent, delete
IB> everything except the subdir and move its contents to root directory.

Even worse, git-svn does doble work, failing to find the parent branch:
The revision is imported 3 times (2 times creating the same SHA)

    r8803 = 7bfe8f8d950edd645c6f15193e639953c0b936ac (refs/remotes/trunk)
    Found possible branch point: file:///home/il/builds/sicap/gitsvn/prd_dmc4.svn/trunk/GUI => file:///home/il/builds/sicap/gitsvn/prd_dmc4.svn/tags/GUI_4.0.25, 8803
    Initializing parent: refs/remotes/tags/GUI_4.0.25@8803
    r6 = de89d3fd4dff9c44f1c79a316364196d0c81c9f6 (refs/remotes/tags/GUI_4.0.25@8803)
    ...
    r8803 = ffc46ad0e967636f2000d354481c0419a4c6cec4 (refs/remotes/tags/GUI_4.0.25@8803)
    Found branch parent: (refs/remotes/tags/GUI_4.0.25) ffc46ad0e967636f2000d354481c0419a4c6cec4
    Following parent with do_switch
    Successfully followed parent
    r8804 = 2cbe962f0fb58c3f2d236ca918941e353da45af4 (refs/remotes/tags/GUI_4.0.25)
    ...


    r8923 = ad38e54ca9bb6b26654571bb14d17301484437dc (refs/remotes/tags/GUI_4.0.26)
    r8924 = e1932e8fdeab291f54ed06064da3ae7eb1e3eddb (refs/remotes/trunk)
    Found possible branch point: file:///home/il/builds/sicap/gitsvn/prd_dmc4.svn/trunk/GUI => file:///home/il/builds/sicap/gitsvn/prd_dmc4.svn/tags/GUI_4.0.26, 8925
    Initializing parent: refs/remotes/tags/GUI_4.0.26@8925
    r6 = de89d3fd4dff9c44f1c79a316364196d0c81c9f6 (refs/remotes/tags/GUI_4.0.26@8925)
    ...
    r8803 = ffc46ad0e967636f2000d354481c0419a4c6cec4 (refs/remotes/tags/GUI_4.0.26@8925)
    r8805 = dac5886451f64e63d70b307bcc6f0c8ccf9c9882 (refs/remotes/tags/GUI_4.0.26@8925)
    ...
