From: Adam Stankiewicz <sheerun@sher.pl>
Subject: Git submodule repository locatio
Date: Wed, 24 Apr 2013 16:44:29 +0200
Message-ID: <5177EFCD.1020300@sher.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 24 16:45:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV0wa-0003no-O3
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 16:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756214Ab3DXOpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 10:45:01 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37718 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756140Ab3DXOod (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 10:44:33 -0400
Received: by mail-ee0-f46.google.com with SMTP id c13so787027eek.5
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 07:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=wopIzf1ju5SOUOpN3xtHAac5BW3ZZLuVpMIbjiF1uVA=;
        b=aFDP1QHYjRk0MtMnT7pdIrGDi0JFwCelZDQK8QLBMEwD+sdcHWqq/Fu7NfpoGqW3M0
         x9PCnsUFZporSVmmP6YYdLXl5aW1HIhpv+X9dCtmuI8DQTSKsKRp/uwQvYCUbLhaTStG
         JydHK1xpssIkOI8KWkCHiUwwCA/NUYHNWoHeWb3OxMhgalIBLj6DVLlogf0sjO+GrGxj
         AUFr3ds13JHN6MjRmyqvhLmvDFJgdkIiXO34fgX92ySoHxxYIcuvyWLDV18EQrwE9jq8
         kVJf7v0kv+Xx9q3f1EOfa3Eg21NW8fyB9VB2ubJyOFzQrXz1TxddJfu6DuIfBXlTw5dh
         nfHQ==
X-Received: by 10.15.43.73 with SMTP id w49mr64478697eev.12.1366814672333;
        Wed, 24 Apr 2013 07:44:32 -0700 (PDT)
Received: from [192.168.1.109] (89-72-253-211.dynamic.chello.pl. [89.72.253.211])
        by mx.google.com with ESMTPSA id ch6sm4612252eeb.17.2013.04.24.07.44.30
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 07:44:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-Gm-Message-State: ALoCoQmXkF6GcdmrlFP4893QdAqKHBCcCWcfyNDOK19i7mqt4D2l23/11Xf37ORPNZHqkku3cCJc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222253>

Currently each submodule contains single .git file (instead of directory)
with only link to project's base repository, for example "gitdir:
../../.git/modules/lib/neobundle.vim".

In git base repository we find .git/modules directory that contains bare
repositories of all submodules, for example .git/modules/lib/neobundle.vim
contains bare repository of neobundle submodule.

My proposal is to move default bare repository location from .git/modules
to .git directory inside submodule, like every normal git repo do.

These are my arguments:

1. Why git submodule needs to know in which project it is embedded in? Or
even that it's generally submodule? When cd to submodule, it behaves like
normal repository. Only repository needs to know about its submodules.
2. You can't move submodule outside git repository and use it as normal git
repo. You have to copy bare repo from .git/modules dir.
3. It's not enough to delete submodule from workingdir to "refresh" it
later. You have to go to .git/modules directory and delete appropriate
folder.

What about performance on checkouts?

In systems supporting symlinks, the .git directory in submodule can be a
symlink to the .git/modules subdirectory. In systems that do not support
them, you can use mv-like command, that is very fast. Just move .git
directory of submodule to .git/modules subdirectory, until you you need it
(when you check out commit with "Subproject commit 55d868e(...) object").

I propose introducing this change in next major version of git, as it can
break some scripts that depend on git submodule repository location.

Please consider this "feature request" seriously, most people I know think
git submodules suck, and described issue is IMHO one of the reasons why.

Sincerely,
Adam Stankiewicz (@sheerun)
