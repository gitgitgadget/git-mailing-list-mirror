From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH v2 0/9] Flags and config to sign pushes by default
Date: Wed, 19 Aug 2015 11:26:38 -0400
Message-ID: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:27:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5Gp-0004p0-PS
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbbHSP1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:27:14 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34012 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbbHSP1N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:27:13 -0400
Received: by iodb91 with SMTP id b91so12915121iod.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ror3i8oSnXrVCDg79kefpfeaEg38jqOufZ2mSl5lbWY=;
        b=Fs7kuJBp0H0oaeoBANffexW+Obrh10pBgY2VJBea2alEUqzBbNB0Sg/Ka+Fnn/8FL3
         lLOTOWSTKyQTx1tWCzMaLPOSWAlCqzi9qEtBpalNdmMuQ5JzEfxgz8Yepo0S52SLzKcw
         1SazOMMz20/STDAmrYbfCHt7hu+eP9jSr3B6lbJ3pma/9DuOPMA7UK4wCdF70NJcXGc6
         Izqi15wDh2mfKqd7ZQcwIyS0Gsw42TKA/0uK0V2bH+UDvp4wUWvIDbmvcrdzqVpCIQwn
         +t9Ulz80nmVDutF//wq5QNjrA7vKD9YpWwDdrfMK/HVqdY0Fp8Rj4jmOm3aeGEBJWu2X
         AjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ror3i8oSnXrVCDg79kefpfeaEg38jqOufZ2mSl5lbWY=;
        b=m6SizoT8cduxsVioa4ydxGlJX3jELIGy62ctME2nnzZCMdsXRXGsLpGHCJ6ej7Fg6z
         ppq6CzG2HMz0Rov5TbFVTCPXyDSDCbjbRIuC9e/A6qGBPCJ0BYKIaEsBQPJYHvqtnvhx
         EGFEZxqJjcnUGsvsqT6RK4OEiI9FfyP6JwtbiHIifaHqRPoGFT4n07vabPt6Qt+yZm1V
         0CcCV5t8m827BJE3Xo0CoJQxIc+L3KgALepUnEt8sfbxRyf/wQTvjsy9iGCRmhtyTtqR
         0lOiRbcrfQlwSYnrCFn4D1RjCwpo/dUl4sdVYaM18NqxOYf/A+uYEIKM0roNeWg68+v2
         P4Dg==
X-Gm-Message-State: ALoCoQlLn/Lha55iGOWujyGIWXujuMQe3QLbVDGEFOGFi4iLCXqGuTtAIVj52C9edX972QEtbJMc
X-Received: by 10.107.11.29 with SMTP id v29mr12978405ioi.186.1439998032740;
        Wed, 19 Aug 2015 08:27:12 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id o19sm2347819igs.18.2015.08.19.08.27.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Aug 2015 08:27:11 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276185>

Changes since v1:
 - Rebased on 44e02239
 - Use options --[no-]signed|--signed=(yes|no|if-asked)
 - Support general yes/true/1/etc. option parsing.
 - Convert builtin/send-pack.c to use option parsing API for better code
   reuse.
 - Various cleanups as suggested by Junio.

v1 can be found at:
http://thread.gmane.org/gmane.comp.version-control.git/275881

Dave Borowitz (9):
  Documentation/git-push.txt: Document when --signed may fail
  Documentation/git-send-pack.txt: Flow long synopsis line
  Documentation/git-send-pack.txt: Document --signed
  gitremote-helpers.txt: Document pushcert option
  transport: Remove git_transport_options.push_cert
  config.c: Expose git_parse_maybe_bool
  builtin/send-pack.c: Use option parsing API
  Support signing pushes iff the server supports it
  Add a config option push.gpgSign for default signed pushes

 Documentation/config.txt            |   8 ++
 Documentation/git-push.txt          |  15 ++-
 Documentation/git-send-pack.txt     |  16 ++-
 Documentation/gitremote-helpers.txt |   3 +
 builtin/push.c                      |  42 +++++++-
 builtin/send-pack.c                 | 192 ++++++++++++++++--------------------
 cache.h                             |   1 +
 config.c                            |   6 +-
 remote-curl.c                       |  16 ++-
 send-pack.c                         |  43 ++++++--
 send-pack.h                         |  12 ++-
 transport-helper.c                  |  34 +++----
 transport.c                         |  11 ++-
 transport.h                         |   6 +-
 14 files changed, 253 insertions(+), 152 deletions(-)

-- 
2.5.0.276.gf5e568e
