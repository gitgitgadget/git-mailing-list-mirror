From: larsxschneider@gmail.com
Subject: [PATCH v3 0/3] config: add '--sources' option to print the source of a config value
Date: Sat, 13 Feb 2016 15:24:13 +0100
Message-ID: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, sschuberth@gmail.com, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, hvoigt@hvoigt.net, sbeller@google.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 15:25:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUb8C-0007ml-Nv
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 15:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbcBMOYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 09:24:22 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35543 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbcBMOYU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 09:24:20 -0500
Received: by mail-wm0-f67.google.com with SMTP id g62so7719717wme.2
        for <git@vger.kernel.org>; Sat, 13 Feb 2016 06:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SNZ/C/CWZyQzzgejcUjeqoH/I2A2qhnCU2IasjESQ2c=;
        b=mKKLmXgIRZAwPghb7pA4vhrdPAxcnJ6jokZ0Jf5IvMsBA2/GikfjGepg9YDesYWQh8
         JCQeIu4NfVvH5dFzirzHh9MGeQ484/IjxbrYhWNDYRLIgQKFHCfkJS922MyZK3l5FILY
         2aQf+nhBstc6LjGG6d9H+YKYewpB/0iEeCUaFNogbUoRTWZ1qoqjh1zFUWfPXGjXxUd2
         BgOqufOAlfum2DYpDIe+CTPg48AqAE7ik7W+v/q3vNTcHTkJmnf8BPL1fuihKFymAGOn
         tSzgBT2mhihaG1UDBhX2B4bTl8CGG90r3VeVVHFTcAxp9fpRZBF/0IQ0bJI3dF/vTzFP
         LAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SNZ/C/CWZyQzzgejcUjeqoH/I2A2qhnCU2IasjESQ2c=;
        b=YHLheHgefnBGmG0x4qXnKTgC+wQM78mqcDRmI7PItemg5b//FX05uWt2t5+6J7e1U1
         w6pVw5ftI18Rqz5O2bUC2zt9joAQVawFi4wAKoUxe6CaTZrM+t5FJA8m61rY8c/bRFsf
         58JiTAVj6GVFufxke7+KQyKuHyVMcjemOxKW1p082nkMvOTU8jvU5BKjk+SSFVr0dxp2
         Dt8eiLS0XHkD2g+zEoLlRBdilV/rfbHP8rNQcNR2aVo+otmU2MptWISpIulEWnF//Zb+
         cE2gX1BSZJ4PZI1KuaeoIKru3j+wpDvuxSbAHSNmpCU2KAHbnXJ5S/UZRfLEiIVRoylo
         ePug==
X-Gm-Message-State: AG10YOTgFy91ZlLy+jVZHQr1twVjGS4kYXsaB+S6Ani2XXu9L4isptVcMepBpADek4cgPA==
X-Received: by 10.28.211.130 with SMTP id k124mr3410133wmg.7.1455373459484;
        Sat, 13 Feb 2016 06:24:19 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB53AE.dip0.t-ipconnect.de. [93.219.83.174])
        by smtp.gmail.com with ESMTPSA id os7sm16754763wjc.18.2016.02.13.06.24.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 13 Feb 2016 06:24:18 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286110>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v2:
* rename cmd to cmdline
* rename function current_config_name to current_config_type_name
* add 'type' to config_source struct that identifies config type
* fix config stdin error output and add test case "invalid stdin config"
* change delimiter between type and name from tab to colon
* remove is_query_action variable
* rename "--sources" to "--show-origin"
* add pathological test case "--show-origin stdin with file include"
* enumerate all valid commandline cases for "--show-origin"
* removed TODOs as there are no config include bugs
* describe '--includes' default behavior in git-config.txt
* split test cases
* use non-interpolated here-docs where possible
* improve readablity of 'show_config_origin' function by removing duality

I renamed the flag from "--source" to "--show-origin" as I got the impression
that Sebastian, Peff and Ramsay seem to be all OK with "--show-origin".

Thanks Eric for the hint to simplify the 'show_config_origin' function.
I took your suggestion but modfied one line. Instead of "fputs" I used
"fwrite" to write the content. This was necssary as the last char of the
string could be \0 due to the "--null" flag. "fputs" would ignore that.

In 959b545 Heiko introduced a config API to lookup .gitmodules values and
in "submodule-config.c" he uses the "git_config_from_buf" function [1]. I
wonder if my modifications to this function could trigger any unwanted side
effects in his implementation? (I can't imagine any but I want to make you
aware of this connection)


Thanks a lot Peff, Sebastian, Ramsey, and Eric for the review.


[1] https://github.com/git/git/blob/494398473714dcbedb38b1ac79b531c7384b3bc4/submodule-config.c#L430-L431


Lars Schneider (3):
  git-config.txt: describe '--includes' default behavior
  config: add 'type' to config_source struct that identifies config type
  config: add '--show-origin' option to print the origin of a config
    value

 Documentation/git-config.txt |  19 ++++--
 builtin/config.c             |  35 +++++++++++
 cache.h                      |   1 +
 config.c                     |  23 +++++---
 t/t1300-repo-config.sh       | 136 ++++++++++++++++++++++++++++++++++++++++++-
 t/t1308-config-set.sh        |   4 +-
 6 files changed, 202 insertions(+), 16 deletions(-)

--
2.5.1
