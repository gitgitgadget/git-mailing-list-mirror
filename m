Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4841FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 12:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbdFJMsj (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 08:48:39 -0400
Received: from ikke.info ([178.21.113.177]:38088 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbdFJMsi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 08:48:38 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 977CA4400B7; Sat, 10 Jun 2017 14:48:36 +0200 (CEST)
Date:   Sat, 10 Jun 2017 14:48:36 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: 'pu' broken at t5304 tonight
Message-ID: <20170610124836.GD27719@alpha.vpn.ikke.info>
References: <xmqq4lvo2x6i.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4lvo2x6i.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 10, 2017 at 03:07:01PM +0900, Junio C Hamano wrote:
> I didn't check where it goes wrong.  Here is a list of suspects,
> taken by
> 
>     $ git shortlog --no-merges pu@{8.hours}..pu
> 
> i.e. patches that weren't in pu before today's integration cycle.
> 
> Andreas Heiduk (1):
>       doc: describe git svn init --ignore-refs
> 
> Brandon Williams (32):
>       config: create config.h
>       config: remove git_config_iter
>       config: don't include config.h by default
>       config: don't implicitly use gitdir
>       setup: don't perform lazy initialization of repository state
>       environment: remove namespace_len variable
>       repository: introduce the repository object
>       environment: place key repository state in the_repository
>       environment: store worktree in the_repository
>       setup: add comment indicating a hack
>       config: read config from a repository object
>       repository: add index_state to struct repo
>       submodule-config: store the_submodule_cache in the_repository
>       submodule: add repo_read_gitmodules
>       submodule: convert is_submodule_initialized to work on a repository
>       convert: convert get_cached_convert_stats_ascii to take an index
>       convert: convert crlf_to_git to take an index
>       convert: convert convert_to_git_filter_fd to take an index
>       convert: convert convert_to_git to take an index
>       convert: convert renormalize_buffer to take an index
>       tree: convert read_tree to take an index parameter
>       ls-files: convert overlay_tree_on_cache to take an index
>       ls-files: convert write_eolinfo to take an index
>       ls-files: convert show_killed_files to take an index
>       ls-files: convert show_other_files to take an index
>       ls-files: convert show_ru_info to take an index
>       ls-files: convert ce_excluded to take an index
>       ls-files: convert prune_cache to take an index
>       ls-files: convert show_files to take an index
>       ls-files: factor out debug info into a function
>       ls-files: factor out tag calculation
>       ls-files: use repository object
> 
> Jeff King (1):
>       date: use localtime() for "-local" time formats
> 
> Johannes Schindelin (8):
>       discover_git_directory(): avoid setting invalid git_dir
>       config: report correct line number upon error
>       help: use early config when autocorrecting aliases
>       read_early_config(): optionally return the worktree's top-level directory
>       t1308: relax the test verifying that empty alias values are disallowed
>       t7006: demonstrate a problem with aliases in subdirectories
>       alias_lookup(): optionally return top-level directory
>       Use the early config machinery to expand aliases
> 
> Junio C Hamano (1):
>       ### match next
> 
> Prathamesh Chavan (1):
>       dir: create function count_slashes
> 
> SZEDER Gábor (5):
>       revision.h: turn rev_info.early_output back into an unsigned int
>       revision.c: stricter parsing of '--no-{min,max}-parents'
>       revision.c: stricter parsing of '--early-output'
>       revision.c: use skip_prefix() in handle_revision_opt()
>       revision.c: use skip_prefix() in handle_revision_pseudo_opt()
> 
> Stefan Beller (1):
>       t4005: modernize style and drop hard coded sha1
> 

For me, this bisects to the latest merge:

2047eebd3 (Merge branch 'bw/repo-object' into pu, 2017-06-10), but
neither of the parent of the merge break this test, so it looks like
it's because of an interaction between the repo-object topic and another
topic.
