From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/3] Submodules: have a depth field in the .gitmodules file
Date: Wed, 25 May 2016 15:00:03 -0700
Message-ID: <20160525220006.27138-1-sbeller@google.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 00:00:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5gqi-0007Sl-Pc
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbcEYWAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:00:14 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35860 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbcEYWAM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 18:00:12 -0400
Received: by mail-pa0-f42.google.com with SMTP id eu11so12632920pad.3
        for <git@vger.kernel.org>; Wed, 25 May 2016 15:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=bUs+d6PfQ8YYmi9o5iI1nyawklcbPpvtbk5bURgjNso=;
        b=IycpVupRARE8C8OFGKU1PGKJbRWjwGf7i7ygesgZVaH5QYZGxHSRsCyUifAfUyU6iB
         zWUvG9WW3L3evZa8jZ44kXsGV52iNHZvkmvpvl5MD6uvVQC1aflwcmmiAxYRKhJIGbqh
         gdPR8KuO0ogsirfOrWGVjPSbuWUlex6HnqQc7e79CgLFlbXEEqW0eFFEkC4hIQMFbCyu
         H91L9JrGqTE69LIPNhR0CtVecY6Wze/S450GUlr6nhjb1xA0nyWN3njsn1KQSZYeD4mQ
         frBu7Uw6bBbJTzoHrSH30wHysk+82SyY4LNXQ6riGv3SpXi7UBMWBNN1VoS0Yzp7OCIu
         ZWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bUs+d6PfQ8YYmi9o5iI1nyawklcbPpvtbk5bURgjNso=;
        b=Z5dlBIs/KHadgCm/Ve9+sHdR+QpPi+WCJPHnIqy1Q3A3Yfowtlh+QPMh+IuWU9B9ma
         LkeiQdkAhF915M24M7YauBE1G+cUlAy6GQ6BwcDT5lJLxUXPPNsnN1H6JMwMFqFF2txj
         2Kkse1pSFaE5qvBcYAZe9KFYtik+bkyxCL66R40tIn4+Y5OFkwL4s48+Vs0A2LIh4Trv
         jcO25bWEQZpHHy7djSS5b5/yzwg3oYJO7HslJu0ZvGFctFQqaFWeDpGIoXoXxMTm+Op3
         QqcFjtPxGk2dFwKOjmZeOy3jDTnz8A/4JnqDonfEXoce5il02O0RHClxnSCJIdXW+ZDn
         4CAw==
X-Gm-Message-State: ALyK8tJ1Q3XdOUw3QfLqloLwS4qZ6yq5t6IQJ4jO++lCKfhbJo1a8CByq34t4Oflx15Q0NKS
X-Received: by 10.66.222.98 with SMTP id ql2mr9164836pac.137.1464213611577;
        Wed, 25 May 2016 15:00:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9ded:7fc0:154a:2e3b])
        by smtp.gmail.com with ESMTPSA id uf5sm15002752pac.44.2016.05.25.15.00.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 May 2016 15:00:10 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.3.g892bdd0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295595>

Sometimes the history of a submodule is not considered important by
the projects upstream. To make it easier for downstream users, allow
a field 'submodule.<name>.depth' in .gitmodules, which can be used
to indicate the recommended depth.

Stefan Beller (3):
  submodule update: make use of the existing fetch_in_submodule function
  submodule-config: keep `depth` around
  submodule update: learn `--recommended-depth` option

 Documentation/git-submodule.txt | 10 ++++++++--
 builtin/submodule--helper.c     |  8 +++++++-
 git-submodule.sh                | 11 +++++++++--
 submodule-config.c              | 16 ++++++++++++++++
 submodule-config.h              |  1 +
 t/t5614-clone-submodules.sh     | 34 ++++++++++++++++++++++++++++++++++
 6 files changed, 75 insertions(+), 5 deletions(-)

-- 
2.9.0.rc0.3.g892bdd0.dirty

base-commit: 3a0f269e7c82aa3a87323cb7ae04ac5f129f036b
