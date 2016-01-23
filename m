From: Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 0/5] [WAS: Submodule Groups] Labels and submodule.autoInitialize
Date: Fri, 22 Jan 2016 16:31:38 -0800
Message-ID: <1453509103-16470-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de,
	jrnieder@gmail.com, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 23 01:32:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMm7T-0006fU-8i
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 01:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618AbcAWAbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 19:31:49 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34183 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755601AbcAWAbs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 19:31:48 -0500
Received: by mail-pf0-f177.google.com with SMTP id q63so51548213pfb.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 16:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=k98U/GqmPtQsBaQ9p0kmzs5aXn9kGrj60Hy3illDvz4=;
        b=n7KA1VGLnIE4+m+rIgk7bXFvpv70OMUPmbm0JbBaEA42BBa17hW0INTSwV1kWJaYzy
         h5S16EAf4HGU09eP6fF/zKGlsZnPPj3AfjduoNqxfO/Sh5j6Wv1ZlApmOEOEW6Rv8lLG
         ae+si4XIwAEaFor9EBu5vn2yIV0Eju3y7TFGyEOPIj+l3b9OPdwddGn9pXBguIcE5Y1q
         vmI7p65Kr4WulSAS/Rq6MiypxDVeDryxanjn9Kzr7+0MfIZPB4cns61xGQUILaBEpjF6
         zYwdi4ZevLY8x+UdrPMDolxeDH4o3J3MtH/30eyfs9gWgD59xqKTHzCksw7uI0CVwSQV
         Vrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k98U/GqmPtQsBaQ9p0kmzs5aXn9kGrj60Hy3illDvz4=;
        b=Vew9f9gsrdZ2v5LTkdho2cAbMqLmPfEsCGc3zlWFlX+KIsOMAgR8Go5bcAC79ljAEU
         Ypc8/U8rCvNpXVHBmTaILnev9hMov6loKb74s+XTkb6MvqTnVLaZp5v3NcMhPCgpE2iE
         0z5GWR0/jSGkioKEpvNmNBSMlxluccX7wK40EkUGb1p6czjMzrbf5TKtFQDE82xHaIu/
         kL7cghrG7Cns1ZbWNwxo5CXO74Fg9X0zo0vQNM8yk8xuLR0s4EHZiX2qHG5Qf+n2Yglm
         0x485O6yduYIPPC+kJ561a77UiyLzddb3M+IUxzT1IvAsxwid6Q5xWK0DR0mH7FFvhm2
         gf+Q==
X-Gm-Message-State: AG10YOSQHXff40mmthwOG4rY1r5p2HWL1QJmJQqy0W7WsdPZj9OwK/5X8WLHvqBEG632UjHo
X-Received: by 10.98.72.136 with SMTP id q8mr8575873pfi.86.1453509107617;
        Fri, 22 Jan 2016 16:31:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:add1:48d1:6b77:ed16])
        by smtp.gmail.com with ESMTPSA id dz12sm12287682pac.2.2016.01.22.16.31.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Jan 2016 16:31:46 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.42.g77a36b9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284612>

This series introduces labels which you can attach to submodules like so:

    $ cat .gitmodules
    [submodule "gcc"]
        path = gcc
        url = git://...
        label = default
        label = devel
    [submodule "linux"]
        path = linux
        url = git://...
        label = default

    $ git submodule add --name emacs --label "editor" --label default git://...
    
    # If upstream has submodules properly labeled, you can make use of them:
    
    $ git config --add submodule.autoInitialize "*default"
    $ git config --add submodule.autoInitialize ":name"
    $ git config --add submodule.autoInitialize "./by/path"
    
    # The prefix * denotes a label as found in .gitmodules
    # : goes before names 
    # path are prefixed ./ currently
    # both path and names need work
    
    # no --init necessary, partially initializes submodules (only those which
    # were specified by label, name or path)
    $ git submodule update
    
    # time passes, upstream may have added new submodules and we get them without
    # extra commands!
    $ git submodule update
    
    # The above configuration can be given to git clone directly via:
    $ git clone --init-submodule=*labelA ...
    
Why?
====
If you have lots of submodules, you probably don't need all of them at once,
but you have functional units. Some submodules are absolutely required,
some are optional and only for very specific purposes.

Changes to the previous version with groups:
====
* it's called labels now (it's easier to imagine to attach more than one
  label to a submodule than having it in more groups)
* In .git/config we have another name, too ("submodule.autoInitialize")
* Support for more than just groups, but also names and paths are supported
  (in a very rudimentary way though)
  
This series applies on top of sb/submodule-init, or can be found at
https://github.com/stefanbeller/git/tree/submodule-groups-v3
  
  Thanks,
  Stefan

Stefan Beller (5):
  submodule init: Write submodule registration to stderr
  git submodule: Teach add to label submodules
  submodule-config: keep labels around
  submodule update: respect submodule.autoInitialize
  builtin/clone: Configure submodule.autoInitialize via --init-submodule

 Documentation/git-clone.txt     |   6 ++
 Documentation/git-submodule.txt |   5 +-
 builtin/clone.c                 |  40 +++++++++-
 builtin/submodule--helper.c     |  58 +++++++++++++-
 git-submodule.sh                |  14 +++-
 submodule-config.c              |  15 ++++
 submodule-config.h              |   2 +
 t/t7400-submodule-basic.sh      | 165 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 298 insertions(+), 7 deletions(-)

-- 
2.7.0.rc0.42.g77a36b9.dirty
