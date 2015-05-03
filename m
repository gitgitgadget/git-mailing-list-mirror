From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v3 0/4] git help: group common commands by themes
Date: Sun, 03 May 2015 02:19:28 +0200
Message-ID: <55456990.6000509@gmail.com>
References: <554405D5.9080702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Luke Diamand <luke@diamand.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 02:19:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YohdG-00061w-F4
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 02:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbbECATe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 20:19:34 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33436 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbbECATc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 20:19:32 -0400
Received: by wgin8 with SMTP id n8so119528438wgi.0
        for <git@vger.kernel.org>; Sat, 02 May 2015 17:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=HsSKICgAf+dNdCDEOghIF9W2SdH+v1Vg5IWaEewOZ/4=;
        b=qCDoyzruzN4ljEntxYpc0aN3kpJdbVZ8EUmqFWrejNURa50pJ4dMydY+hQPx0Mfo81
         410KJoFS3ipbPahNKIq1+DQYcZrFaaidSV2qztVRufHdWxS33aF9y7TWYtPSYMzMCaqG
         31WuxpjO6DeAD7so9wCpmryaiFOWoqcnPZBfbhqLTelAFLlgyjYoNxTTovdGLj5zGfHJ
         61T9vrfxhF3lMwYCXUpWb0+8eBmhowMVRRji6olX1AqujO5ChQL2eKvoja6lDyFygc1f
         2f3zoHAr+YHT8p4dMSodtWPhtPjHIoYy3HLYNQmRbXLYX8G/NMdh0w9Q2gTVD1UKWtof
         hyTQ==
X-Received: by 10.194.60.43 with SMTP id e11mr30426555wjr.36.1430612370868;
        Sat, 02 May 2015 17:19:30 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id mc20sm4379429wic.15.2015.05.02.17.19.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 May 2015 17:19:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <554405D5.9080702@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268241>

Group the common commands printed by 'git help' (or 'git' without any
options) into beginner friendly themes. To achieve this, the file
command-list.txt receives an additional information for all 'common'
commands, in the form of an indexed group suffix.

Group suffixes are in the form: 'x_group', where x is a number used to
order (ascending) commands in the displayed help:

[...]

git-add                                 mainporcelain common-3_worktree
git-bisect                              mainporcelain common-7_search
git-branch                              mainporcelain common-6_branching
git-checkout                            mainporcelain common-6_branching

[...]

Note: the proposed layout comprises:

1_init
2_info
3_worktree
4_remote
5_history
6_branching
7_search

They can be easily modified by just changing command-list.txt

command-list.txt is then parsed by generate-cmdlist.sh to generate
common-cmds.h with the additional group name being a 'group' field in
the cmdname_help struct:

[...]

    {"add", N_("Add file contents to the index"), "3_worktree"},
    {"bisect", N_("Find by binary search the change that introduced a
bug"), "7_search"},
    {"branch", N_("List, create, or delete branches"), "6_branching"},
    {"checkout", N_("Checkout a branch or paths to the working tree"),
"6_branching"},

[...]

Finally, list_common_cmds_help() prints those common commands by groups,
skipping a line between each group:

[...]

The most commonly used git commands are:
     clone      Clone a repository into a new directory
     init       Create an empty Git repository or reinitialize an
existing one

     log        Show commit logs
     show       Show various types of objects
     status     Show the working tree status

     add        Add file contents to the index
     mv         Move or rename a file, a directory, or a symlink
     reset      Reset current HEAD to the specified state
     rm         Remove files from the working tree and from the index

     fetch      Download objects and refs from another repository
     pull       Fetch from and integrate with another repository or a
local branch
     push       Update remote refs along with associated objects

     commit     Record changes to the repository
     diff       Show changes between commits, commit and working tree, etc
     rebase     Forward-port local commits to the updated upstream head
     tag        Create, list, delete or verify a tag object signed with GPG

[...]

The documentation api-builtin.txt is updated to reflect the change.
