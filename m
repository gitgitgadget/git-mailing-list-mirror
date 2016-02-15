From: larsxschneider@gmail.com
Subject: [PATCH v4 0/3] config: add '--sources' option to print the source of a config value
Date: Mon, 15 Feb 2016 11:17:43 +0100
Message-ID: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, sschuberth@gmail.com, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, hvoigt@hvoigt.net, sbeller@google.com,
	Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 11:17:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVGE7-0003R4-5D
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 11:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbcBOKRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 05:17:50 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38477 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbcBOKRt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 05:17:49 -0500
Received: by mail-wm0-f48.google.com with SMTP id a4so49045416wme.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 02:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JTGKQr3pdy3B9gsT/wLzU7JaNteRUUoDrbZb9Jaar08=;
        b=N9H0y6v5QCRY05eQCTeY6va6vmXqyDIQbEZapN/joxLsOPKmzt7NYzyaJh+KxUxV3U
         EwtxHGMGiEKpyFrsqiPuuq4BFyJl0PggdNvv8rWJ7P7yMjXg5iWrILW0TK1njB+UIJVj
         /zJc7wFobUShrMPcCBsZKy/fW0ZfFqZCRGYhpdJSRfLnJ7V8cJT/b58QjDHqNaPenVAP
         /zWxLdW3juqH8zCmbmKTA+qgk9sVnrL1UQlsTToD70Dde2I1VcDcogt97vw9MGAhhM5b
         0g35QqSPYeM+9XDj9sMM4PG5bEygquXCOCtk3q6lHE0CtCS6cHACjXoW9JhLUbuRfFLW
         JI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JTGKQr3pdy3B9gsT/wLzU7JaNteRUUoDrbZb9Jaar08=;
        b=hG8APtSA9ZkfnMPtAdEd3Lj+RxV/VVR2jqPsS9DT62WUezh0yo4IVMHPoUKSmA8IhS
         CS4OqFfDB9YzrWCDo6ygHHOGZddIFxPfjlfcjADLQ0c5gExizqWGJ7i28C20Xz2cvsR6
         XRBgD24ns4QMVbdfcNEFt+eIeVuZtKhy0xSzSyEiUDgojoUqG9O2RFB3syb0vXPt4RIo
         Z1oCep06pPxf/T20OTwcO8a9PxzbNvW0MtgRIv4RNz0dymTER0Kpc69OjhfUhp6xKjYp
         BeYx7n19R6LN9E0INpISCDYOaN62lgVuEI4IMlvZWZaHTk+2wCj4FcNvFs2ca0aeb+Op
         ryqA==
X-Gm-Message-State: AG10YOR9fvXZJXgpqkvjvwex5iJI3Kuex7vKE3O4m7x44efC2UL9RKxHDg4gwTK3lGgU5A==
X-Received: by 10.28.184.137 with SMTP id i131mr11145693wmf.96.1455531468832;
        Mon, 15 Feb 2016 02:17:48 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB477C.dip0.t-ipconnect.de. [93.219.71.124])
        by smtp.gmail.com with ESMTPSA id i5sm24494120wja.23.2016.02.15.02.17.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 15 Feb 2016 02:17:47 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286197>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v3:

* pass type as parameter to "git_config_from_mem" (renamed from
  "git_config_from_buf") and "do_config_from_file"
* split current_config_type_name into two functions
* explain usage of fwrite with a comment
* use tabs instead of spaces to fix indentation error
* squash Peff's commit to split the test cases
* sort all test configs key/value pairs in the same way
* add comment to explain newline introduce by here-doc
* use real tabs for test file name
* add a test teardown
* fix hiding of git exit code t1300 and t7008
* drop "git-config.txt: describe '--includes' default behavior" patch

I like the idea of a "test set up block" within a test script. In order
to clean up nicely before any subsequent tests I would like to propose
a "tear down" block. Would that work as a compromise in our "test cases
depend on earlier test cases" discussion?

In "t: do not hide Git's exit code in tests" I also fixed a few more
places where Git's exit code was hidden. Please drop this patch if you
think that this should not be part of this series.

Thanks a lot for the reviews and explainations,
Lars

Lars Schneider (3):
  t: do not hide Git's exit code in tests
  config: add 'type' to config_source struct that identifies config type
  config: add '--show-origin' option to print the origin of a config
    value

 Documentation/git-config.txt |  15 ++--
 builtin/config.c             |  33 +++++++++
 cache.h                      |   6 +-
 config.c                     |  36 +++++++---
 submodule-config.c           |   4 +-
 t/t1300-repo-config.sh       | 167 ++++++++++++++++++++++++++++++++++++++++++-
 t/t1308-config-set.sh        |   4 +-
 t/t7008-grep-binary.sh       |   3 +-
 8 files changed, 242 insertions(+), 26 deletions(-)

--
2.5.1
