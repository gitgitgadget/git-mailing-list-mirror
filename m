From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Port `git submodule init` from shell to C
Date: Fri, 15 Jan 2016 15:37:13 -0800
Message-ID: <1452901035-1802-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, j6t@kdbg.org, sunshine@sunshineco.com,
	Jens.Lehmann@web.de, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 16 00:38:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKDwO-0007Sl-LN
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jan 2016 00:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbcAOXhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 18:37:20 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34961 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbcAOXhS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 18:37:18 -0500
Received: by mail-pf0-f181.google.com with SMTP id 65so124859473pff.2
        for <git@vger.kernel.org>; Fri, 15 Jan 2016 15:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mXNzAob1iOl8k93c1VQ5tZq/lnqExtrIxN6z9Ncwlro=;
        b=n8gGagX4FXNE1nxuWPSHTcvHrgTKQDH7tjdJcgMDqEZUyHRUG0ouG83IyzDBnFqhIz
         EmwcL7SsJFIIEPUdO2uyzB1qjeaajyaNydOpn8d7ax22ccx8HVSFsCpdHF2C7kLNEs4m
         QK6/Ow05qq5J4G+SGfCimj9oxVOyPJJ4tNXV5zxVUX3IUlVmHUc1S5kM4rhfbwjXXYo1
         nM2DoQoQ7l0g85LefeAFp98/oLs8ll8RRMGJAWaRBtGPwl0IK67msO0hk7X1k4jW6TcA
         x8SMhrzj2083oVOmTFftm9jo6fkGxsr1AQcGn0NeH96jMtBrqP3KUVtICxckHm5nGXBd
         knfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mXNzAob1iOl8k93c1VQ5tZq/lnqExtrIxN6z9Ncwlro=;
        b=jcgaZKg9t6rHh8/GvSuwd4AMO/ey8xr6fF8vA+IiA0n9u6kr7MFfwGnLDgZ9uh2Q2g
         VcNX37/ez3PMVkOKMUO8D+1gN4R3Slk1zZpXFzol6Rc58AHfpU9RxcaPD0yJwYVN702a
         suJqiC8MKL5i8yEWXtfSnV1Bwk8VGjg5egn1+BiPHF3KL7p9RKh9PuUReCT7XU9GjyEf
         x+VvVnCBWV+ilb7kBLdxgaaFz7A/GLbFt4ZQEm2rfWHVLRdPYNf/ibBFr0SuUvfV4W7r
         42s3lV8l+nYmWalxptN0xTd9htGuW/SrYyd8KRfeYVffe0+iCkHcybNJp7FhkAkrCpE6
         IFgA==
X-Gm-Message-State: ALoCoQndqfAK5aojVrgcbwcm76HldWHFm7kfhtyu+ZMsE00AiuP6vdpRHyj2r1PhzHUXoKgBpB76lzsZQNLan1eyeMCk12sWWQ==
X-Received: by 10.98.75.139 with SMTP id d11mr18505922pfj.57.1452901038257;
        Fri, 15 Jan 2016 15:37:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:698b:ab72:c6a:e39c])
        by smtp.gmail.com with ESMTPSA id 89sm17806037pfi.2.2016.01.15.15.37.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Jan 2016 15:37:17 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.37.gb4a0220.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284234>

The first patch is a reroll of "[PATCH] submodule: Port resolve_relative_url
from shell to C" and the second patch is new.

This applies on top of origin/sb/submodule-parallel-update, as it makes use
of the recorded update strategy in the submodule configuration.

Thanks,
Stefan

Stefan Beller (2):
  submodule: Port resolve_relative_url from shell to C
  submodule: Port init from shell to C

 builtin/submodule--helper.c | 330 +++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh            | 118 +---------------
 t/t0060-path-utils.sh       |  42 ++++++
 3 files changed, 370 insertions(+), 120 deletions(-)

-- 
2.7.0.rc0.37.gb4a0220.dirty
