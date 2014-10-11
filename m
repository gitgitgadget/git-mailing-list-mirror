From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 1/2] mergetool: don't require a work tree for
 --tool-help
Date: Sat, 11 Oct 2014 01:29:56 -0700
Message-ID: <20141011082954.GA79450@gmail.com>
References: <1412931104-74648-1-git-send-email-davvid@gmail.com>
 <FCAAE5E4-E220-4B45-A6A1-B2AFB79F9069@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Charles Bailey <cbailey32@bloomberg.net>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Oct 11 10:30:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xcs41-0005GK-QL
	for gcvg-git-2@plane.gmane.org; Sat, 11 Oct 2014 10:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbaJKIaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 04:30:02 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:46721 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbaJKI37 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2014 04:29:59 -0400
Received: by mail-pa0-f41.google.com with SMTP id eu11so3124831pac.0
        for <git@vger.kernel.org>; Sat, 11 Oct 2014 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NmlV1hWgfzQ6eX3Ohf50amK4K4yvsVBbXfa/TAuuWPA=;
        b=i2eQGwNcgKM9EvbxiaATUX66YVPMICIaY9MPt71SBhbpfhabclYzdiaO3uIvW5k1VR
         SQye9n2Q0JTMt+JZRhd2eCWf4XOVMYHWQaUGZCbfxjju7i6TL7KDXX4AHVLGLqR41D7D
         hD/GJzRu5Sg/mrdjD04GeFAifPBhHMPBDU+tK5fw0jkAduXPYNkVN3eEnu9avHZ9hA4v
         WavGXh/XxOMtgWGE52sMLdU65tHEDrpVrZBD76du2wap1S4vyJodbySnkJik8SdLqp5G
         qVP0dZXZqeIVmD20ezWa5jiHcXWBkGXC5GFy7FECUFCYy5q5SrTp2l3hqdXf2qH430m/
         abmg==
X-Received: by 10.68.57.232 with SMTP id l8mr10508510pbq.107.1413016199144;
        Sat, 11 Oct 2014 01:29:59 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id b4sm5552896pdh.2.2014.10.11.01.29.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 11 Oct 2014 01:29:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <FCAAE5E4-E220-4B45-A6A1-B2AFB79F9069@hashpling.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 10, 2014 at 10:01:57AM +0100, Charles Bailey wrote:
> On 10 Oct 2014, at 09:51, David Aguilar <davvid@gmail.com> wrote:
> > Changes since v1:
> > 
> > NONGIT_OK=Yes was added to make it actually work outside of a git repo.
> 
> Does this actually work? The reason that I haven't got around
> to resending my re-roll is that I found that I needed changes
> to git-sh-setup.sh because doing NONGIT_OK and then
> require_work_tree didn't correctly set GIT_DIR when it wasn't
> already explicitly set in the environment. (I believe the rest
> of mergetool relies on it.)
> 
> Perhaps I misunderstood, though.

Thanks for the heads-up.

I tested mergetool and it seems fine but indeed there's an
`if test -e "$GIT_DIR/MERGE_RR"` in there that is surely not
working as intended.

One solution would be to move the work done in the test -z "$NONGIT_OK"
block in git-sh-setup into a function e.g. git_dir_init () so
that we can defer the GIT_DIR initialization until after
require_work_tree has been called.
-- 
David
