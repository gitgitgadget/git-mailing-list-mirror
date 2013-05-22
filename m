From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v13 00/15] interactive git-clean
Date: Wed, 22 May 2013 09:40:21 +0800
Message-ID: <cover.1369186574.git.worldhello.net@gmail.com>
References: <7vhahwm5n6.fsf@alter.siamese.dyndns.org>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 03:41:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uey34-0001My-UB
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 03:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580Ab3EVBkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 21:40:47 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:48782 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab3EVBkq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 21:40:46 -0400
Received: by mail-pb0-f43.google.com with SMTP id ma3so1202079pbc.16
        for <git@vger.kernel.org>; Tue, 21 May 2013 18:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=G5l+JLSUbv1l/rS0fExIr6GTyPZpXYs5yV8Sxm9NiuA=;
        b=AnegD11RDmV4FyGA4jou83DhByxnXpzwMa9i2PfgGnbeijMbqzc5WHC2/n27joS+Z5
         qwMQu0zAnmqXnQM4vhl2/SfIEi6VNRvsGsgzFOLBcofSh9KDhNo2jumBow4tmtpiFOge
         PSBeSB7y6Xfc4OQJqu3DEhRrb/tNkgDlGir+ZnILfWdcwJQZXvvrvNnn/G6GjzxOLFlP
         3mpkyJ0JdpxK7YIcuafTMLKMddwCTyQD+YmP2IDd0GVRWAbiNXOG+yvrHAbYZQUbhkDd
         GNYNUdjO0zd2SHVlW8ouWp0yQNaPT47EetmqX+QQohJzYnwycpWSQX5ugZ7YhCZhN7wD
         k0Zg==
X-Received: by 10.66.242.166 with SMTP id wr6mr5951430pac.59.1369186846412;
        Tue, 21 May 2013 18:40:46 -0700 (PDT)
Received: from localhost.localdomain ([114.248.150.82])
        by mx.google.com with ESMTPSA id at1sm4939345pbc.10.2013.05.21.18.40.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 18:40:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.368.g7c798dd
In-Reply-To: <7vhahwm5n6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225104>

2013/5/22 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> diff --git a/test-path-utils.c b/test-path-utils.c
>> index 0092cb..18267 100644
>> --- a/test-path-utils.c
>> +++ b/test-path-utils.c
>> @@ -1,6 +1,19 @@
>>  #include "cache.h"
>>  #include "string-list.h"
>>
>> +#define PARSE_ARGV_STRING(var, input) do { \
>> +     if (!strcmp(input, "<null>")) { \
>> +             var = NULL; \
>> +     } else if (!strcmp(input, "<empty>")) { \
>> +             var = ""; \
>> +     } else if (*input == '<' || *input == '(') { \
>> +             fprintf(stderr, "Bad value: %s\n", input); \
>> +             return 1; \
>> +     } else { \
>> +             var = input; \
>> +     } \
>> +} while (0)
>
> Yuck. Why does it have to be a macro like this?  I do not think
> "because we may return" justifies it.

Rewrite patch 01/15 for this, and only patch 01/15 and 02/15 need update.
Please review.

Jiang Xin (15):
  test: add test cases for relative_path
  path.c: refactor relative_path(), not only strip prefix
  quote.c: remove path_relative, use relative_path instead
  Refactor quote_path_relative, remove unused params
  Refactor write_name_quoted_relative, remove unused params
  git-clean: refactor git-clean into two phases
  git-clean: add support for -i/--interactive
  git-clean: show items of del_list in columns
  git-clean: add colors to interactive git-clean
  git-clean: use a git-add-interactive compatible UI
  git-clean: add filter by pattern interactive action
  git-clean: add select by numbers interactive action
  git-clean: add ask each interactive action
  git-clean: add documentation for interactive git-clean
  test: add t7301 for git-clean--interactive

 Documentation/config.txt     |  21 +-
 Documentation/git-clean.txt  |  71 +++-
 builtin/clean.c              | 778 +++++++++++++++++++++++++++++++++++++++++--
 builtin/grep.c               |   5 +-
 builtin/ls-files.c           |  16 +-
 cache.h                      |   2 +-
 path.c                       | 112 +++++--
 quote.c                      |  65 +---
 quote.h                      |   7 +-
 setup.c                      |   5 +-
 t/t0060-path-utils.sh        |  23 ++
 t/t7301-clean-interactive.sh | 439 ++++++++++++++++++++++++
 test-path-utils.c            |  27 ++
 wt-status.c                  |  17 +-
 14 files changed, 1437 insertions(+), 151 deletions(-)
 create mode 100755 t/t7301-clean-interactive.sh

-- 
1.8.3.rc3.368.g7c798dd
