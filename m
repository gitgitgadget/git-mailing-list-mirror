Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B9BF1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 08:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfBGIEZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 03:04:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36447 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfBGIEY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 03:04:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so10453219wrv.3
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 00:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1PSArFoI9lJyv4DDmNpdslPZgECy1yzpLMIRmBkKcA=;
        b=SUyRScySEFxN6Y+QdJ4qxFDnuBDE1uC5S2Q8rlEow1/PaVwkTwoJm7cKUDFwy8eLpT
         Q58ahDvzvge28i2qbQomHzO6lPGh4SfyRFRTSRna6OTSq8Ke1hXoMMTEJ3l+zDsdEdpE
         HoS9IFjFUd21ocrgfBJq6BGJ4PQ5oWoilepXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1PSArFoI9lJyv4DDmNpdslPZgECy1yzpLMIRmBkKcA=;
        b=HGxdVUSrqahoPL10L9LCEZ47YiPdFgsCivkuixnxE0dJ+qpOmmkFaBUMVqvtl4+qku
         Zl+omgsrilddy6X5GRgqSCNTwDaryEcv8nlg/Gm4jxLZ2EScMhDzBpgPFGCeGS8nS96q
         pufAC4FuPESg2P6TUVEBMI4Y3pgPNyNnmSGZS+rd4NgZLz3C1EkzybpK64/E8/98l4PT
         hOzGInzsfd+t+ykVZWa8y/t5arp2i/Bakot5p8g8dlzUQV7e9xrEmRs6OS5olzUy/sE+
         w/B62dGwJdbgiQ7R5uJsiN9tJJmYuYCquqdtw5XVn4gYKxxoE7Cj6ngj1GhJAhcvBW3s
         4bog==
X-Gm-Message-State: AHQUAuabKmiGgRaz4VpJ6lq8Zs4h4hAAf71xWtjQYMSz//cahfSbT/mG
        4x8VHLKSANRfxjooSUYnzhVgjA==
X-Google-Smtp-Source: AHgI3IZzOv+nsolk8MWNvu43Nov89H6Plb9B7PjF1EdinI9ZfWiJfedQyQcI63TwDh8sl46kUDZbmQ==
X-Received: by 2002:a5d:4cd0:: with SMTP id c16mr11605760wrt.221.1549526662302;
        Thu, 07 Feb 2019 00:04:22 -0800 (PST)
Received: from ethel ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id c10sm17875584wrr.69.2019.02.07.00.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 00:04:21 -0800 (PST)
Date:   Thu, 7 Feb 2019 08:04:20 +0000
From:   Luke Diamand <luke@diamand.org>
To:     andrew@adoakley.name
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] git-p4: recover from inconsistent perforce history
Message-Id: <20190207080420.395c521be017dafb6561784b@diamand.org>
In-Reply-To: <20190206194219.15507-1-andrew@adoakley.name>
References: <20190206194219.15507-1-andrew@adoakley.name>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed,  6 Feb 2019 19:42:19 +0000
andrew@adoakley.name wrote:

> From: Andrew Oakley <andrew@adoakley.name>
> 
> Perforce allows you commit files and directories with the same name, so
> you could have files //depot/foo and //depot/foo/bar both checked in.  A
> p4 sync of a repository in this state fails.  Deleting one of the files
> recovers the repository.
> 
> When this happens we want git-p4 to recover in the same way as perforce.

I'm finding the test fails for me on a clean git repo, although I can't see any obvious reason why.

Having the ability to detect when Perforce users submit a change which creates a file-inside-a-file will be really very useful.

Luke


> 
> Signed-off-by: Andrew Oakley <andrew@adoakley.name>
> ---
>  git-p4.py                      | 41 ++++++++++++++++++++++--
>  t/t9834-git-p4-file-dir-bug.sh | 58 ++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+), 2 deletions(-)
>  create mode 100755 t/t9834-git-p4-file-dir-bug.sh
> 
> diff --git a/git-p4.py b/git-p4.py
> index 3e12774f96..6bf2bbbcec 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -3012,6 +3012,43 @@ def hasBranchPrefix(self, path):
>              print('Ignoring file outside of prefix: {0}'.format(path))
>          return hasPrefix
>  
> +    def isIncluded(self, path):
> +        return self.inClientSpec(path) and self.hasBranchPrefix(path)
> +
> +    def findShadowedFiles(self, files, change):
> +        # Perforce allows you commit files and directories with the same name,
> +        # so you could have files //depot/foo and //depot/foo/bar both checked
> +        # in.  A p4 sync of a repository in this state fails.  Deleting one of
> +        # the files recovers the repository.
> +        #
> +        # Git will not allow the broken state to exist and only the most recent
> +        # of the conflicting names is left in the repository.  When one of the
> +        # conflicting files is deleted we need to re-add the other one to make
> +        # sure the git repository recovers in the same way as perforce.
> +        deleted = [f for f in files if f['action'] in self.delete_actions]
> +        to_check = set()
> +        for f in deleted:
> +            path = f['path']
> +            to_check.add(path + '/...')
> +            while True:
> +                path = path.rsplit("/", 1)[0]
> +                if path == "/" or path in to_check:
> +                    break
> +                to_check.add(path)
> +        to_check = [p for p in to_check if self.isIncluded(p)]
> +        if to_check:
> +            stat_result = p4CmdList(
> +                ["fstat", "-T", "depotFile,headRev,headType"] +
> +                    ["%s@%s" % (p, change) for p in to_check])
> +            for record in stat_result:
> +                if record['code'] != 'stat':
> +                    continue
> +                files.append({
> +                    'action': 'add',
> +                    'path': record['depotFile'],
> +                    'rev': record['headRev'],
> +                    'type': record['headType']})
> +
>      def commit(self, details, files, branch, parent = "", allow_empty=False):
>          epoch = details["time"]
>          author = details["user"]
> @@ -3023,8 +3060,8 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
>          if self.clientSpecDirs:
>              self.clientSpecDirs.update_client_spec_path_cache(files)
>  
> -        files = [f for f in files
> -            if self.inClientSpec(f['path']) and self.hasBranchPrefix(f['path'])]
> +        files = [f for f in files if self.isIncluded(f['path'])]
> +        self.findShadowedFiles(files, details["change"])
>  
>          if gitConfigBool('git-p4.keepEmptyCommits'):
>              allow_empty = True
> diff --git a/t/t9834-git-p4-file-dir-bug.sh b/t/t9834-git-p4-file-dir-bug.sh
> new file mode 100755
> index 0000000000..9839a3d2bb
> --- /dev/null
> +++ b/t/t9834-git-p4-file-dir-bug.sh
> @@ -0,0 +1,58 @@
> +#!/bin/sh
> +
> +test_description='git p4 directory/file bug handling
> +
> +This test creates files and directories with the same name in perforce and
> +checks that git-p4 recovers from the error at the same time as the perforce
> +repository.'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'init depot' '
> +	(
> +		cd "$cli" &&
> +
> +		touch add_file_add_dir_del_file add_file_add_dir_del_dir &&
> +		p4 add add_file_add_dir_del_file add_file_add_dir_del_dir &&
> +		mkdir add_dir_add_file_del_file add_dir_add_file_del_dir &&
> +		touch add_dir_add_file_del_file/file add_dir_add_file_del_dir/file &&
> +		p4 add add_dir_add_file_del_file/file add_dir_add_file_del_dir/file &&
> +		p4 submit -d "add initial" &&
> +
> +		rm -f add_file_add_dir_del_file add_file_add_dir_del_dir &&
> +		mkdir add_file_add_dir_del_file add_file_add_dir_del_dir &&
> +		touch add_file_add_dir_del_file/file add_file_add_dir_del_dir/file &&
> +		p4 add add_file_add_dir_del_file/file add_file_add_dir_del_dir/file &&
> +		rm -rf add_dir_add_file_del_file add_dir_add_file_del_dir &&
> +		touch add_dir_add_file_del_file add_dir_add_file_del_dir &&
> +		p4 add add_dir_add_file_del_file add_dir_add_file_del_dir &&
> +		p4 submit -d "add conflicting" &&
> +
> +		p4 delete -k add_file_add_dir_del_file &&
> +		p4 delete -k add_file_add_dir_del_dir/file &&
> +		p4 delete -k add_dir_add_file_del_file &&
> +		p4 delete -k add_dir_add_file_del_dir/file &&
> +		p4 submit -d "delete conflicting"
> +	)
> +'
> +
> +test_expect_success 'clone with git-p4' '
> +	git p4 clone --dest="$git" //depot/@all
> +'
> +
> +test_expect_success 'check final contents' '
> +	test_path_is_dir "$git/add_file_add_dir_del_file" &&
> +	test_path_is_file "$git/add_file_add_dir_del_dir" &&
> +	test_path_is_dir "$git/add_dir_add_file_del_file" &&
> +	test_path_is_file "$git/add_dir_add_file_del_dir"
> +'
> +
> +test_expect_success 'kill p4d' '
> +	kill_p4d
> +'
> +
> +test_done
> -- 
> 2.19.2
> 


-- 
Luke Diamand <luke@diamand.org>
