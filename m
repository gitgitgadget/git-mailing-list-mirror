Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D57461F404
	for <e@80x24.org>; Mon, 16 Apr 2018 17:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbeDPRr7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 13:47:59 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:51404 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeDPRr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 13:47:58 -0400
Received: from [192.168.2.201] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 88ELfjkQhwhea88EMf41j9; Mon, 16 Apr 2018 18:47:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1523900876;
        bh=KmlOvHGnG1FwO5XfqeBvvNUJQm0wmt/Yum0HOLOUfo8=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QxtipY6m407eBsAUDiSzFWvIujuoNxgbOqSIPbPW4zAFT2OrbR/5Cx0SCafrJiaiD
         tt/CRO3IByhSDrxTUUOejHAlsNjfFBqngIjAUMcfpk+5cSrD4QkuBrq5IlryhqVbQJ
         RLdMN4RD4s3GuNHAP/Ltw/uB4Q6hazNp8/Lc5kDk=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=mDV3o1hIAAAA:8 a=dhlFqCGBWbxg5jYxU44A:9 a=QEXdDO2ut3YA:10
 a=RfR_gqz1fSpA9VikTjo0:22 a=_FVE-zBwftR9WsbkzFJk:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Lars Schneider <larsxschneider@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, mgorny@gentoo.org,
        rtc@helen.PLASMA.Xg8.DE, winserver.support@winserver.com,
        tytso@mit.edu
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com>
 <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
 <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
 <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
 <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
 <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
 <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com>
 <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com>
 <xmqqbmekylgc.fsf@gitster-ct.c.googlers.com>
 <CA+55aFxP8j7YbYaRXt-8Y0n8cHafB=FPKMy8gKFYH5QsKX4S=Q@mail.gmail.com>
 <F1738316-71EF-4053-82E5-F009F491CCE8@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <21d15f6b-f4ab-2efc-47a9-6cbf95cf80d7@talktalk.net>
Date:   Mon, 16 Apr 2018 18:47:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <F1738316-71EF-4053-82E5-F009F491CCE8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfONMZgBel+8sWJrQAkYTLqIwtsQZRNqlLNiWfAndEFrDBfChnAMwSwwxVM0XoFWOc8tMlnJ/RwXLlVSl7qHw2PDCgp+YrzJf+B9eRxr38DlupYsyZV/q
 C3oisR6FYiakwDYV9v9N6GZBisI2Qt4D28jaJ+RxyO7NhOQqss5wzpDwtWgo6lLqzEKElp5hlZFnZeJsV5Ba4rLmZRONvxS7ti7ARAw8gnCmDkjffNeE11k+
 j6T+trKi11fyBjNtDNo2XZNQVuMtgXgpXBZJW/cokqvYvGsNKKczHUq8EDNrCkebFMxQIez4LAGyu5rQi7+WBWvu6aJtqfjuOVWltlZ/WrgamPTuMVhf5B7K
 TFqLEbz3P/99huGgF6sI4Lntd/WPlVM1q5P3IfipoYnDKtDHRR418V7Y9ogWMUHK4Xvd/Jq/mzcWEapwfvjtP4X/dJY4QA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/04/18 17:07, Lars Schneider wrote:
> 
> I am happy to see this discussion and the patches, because long rebuilds 
> are a constant annoyance for us. We might have been bitten by the exact 
> case discussed here, but more often, we have a slightly different 
> situation:
> 
> An engineer works on a task branch and runs incremental builds — all 
> is good. The engineer switches to another branch to review another 
> engineer's work. This other branch changes a low-level header file, 
> but no rebuild is triggered. The engineer switches back to the previous 
> task branch. At this point, the incremental build will rebuild 
> everything, as the compiler thinks that the low-level header file has
> been changed (because the mtime is different).
> 
> Of course, this problem can be solved with a separate worktree. However, 
> our engineers forget about that sometimes, and then, they are annoyed by 
> a 4h rebuild.
> 
> Is this situation a problem for others too?
> If yes, what do you think about the following approach:
> 
> What if Git kept a LRU list that contains file path, content hash, and 
> mtime of any file that is removed or modified during a checkout. If a 
> file is checked out later with the exact same path and content hash, 
> then Git could set the mtime to the previous value. This way the 
> compiler would not think that the content has been changed since the 
> last rebuild.

Hi Lars

But if there has been rebuild between the checkouts then you
want the compiler to rebuild. I've been using the script below
recently to save and restore mtimes around running rebase to squash
fixup commits. To avoid restoring the mtimes if there has been a
rebuild since they were stored it takes a list of build sentinels and
stores their mtimes too - if any of those change then it will refuse
to restore the original mtimes of the tracked files (if you give a
path that does exist when the mtimes are stored then it will refuse to
restore the mtimes if that path exists when you run 'git mtimes
restore'). The sentinels can be specified on the commandline when
running 'git mtimes save' or stored in multiple mtimes.sentinal config
keys.

Best Wishes

Phillip

--->8---

#!/usr/bin/perl

# Copyright (C) 2018 Phillip Wood <phillip.wood@dunelm.org.uk>
#
# git-mtimes.perl
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.

use 5.008;
use strict;
use warnings;
use File::Copy (qw(copy));
use File::Spec::Functions (qw(abs2rel catfile file_name_is_absolute rel2abs));
use Storable ();

sub git;

my $GIT_DIR = git(qw(rev-parse --git-dir)) or exit 1;
$GIT_DIR = rel2abs($GIT_DIR);
my $mtimes_path = "$GIT_DIR/mtimes";

sub git {
    my @lines;
    # in a scalar context slurp removing any trailing $/
    # in an array context return a list of lines
    {
	local $/ = wantarray ? $/ : undef;
	local $,=' ';
	open my $fh, '-|', 'git', @_ or die "git @_ failed $!";
	@lines = <$fh>;
	chomp @lines;
	unless (close $fh) {
	    $? == -1 and die "git @_ not found";
	    my $code = $? >> 8;
	    $_[0] eq 'config' and $code == 1 or
		die "git @_ failed with exit code $code"
	}
    }
    wantarray and return @lines;
    @lines and chomp @lines;
    return $lines[0];
}

sub ls_files {
    # mode, uid, gid, mtime and maybe atime
    my @stat_indices = $_[0] ? (2, 4, 5, 9, 8) : (2, 4, 5, 9);
    local $_;
    local $/ = "\0";
    my @files;
    for (git(qw(ls-files --stage -z))) {
	if (/^[^ ]+ ([^\t]+) 0\t(.*)/) {
	    my @stat = stat($2);
	    # store name, hash, mode, uid, gid, mtime and maybe atime
	    push @files, [ $2, $1, @stat[@stat_indices] ];
	}
    }
    return @files;
}

sub get_config {
    local $/ = "\0";
    my $get = wantarray ? '--get-all' : '--get';
    git(qw(config -z), $get, @_);
}

sub save {
    local $_;
    my @sentinels = get_config('mtimes.sentinel');
    push @sentinels, @ARGV;
    @sentinels or die "No sentinels given";
    @sentinels = map { [ $_, [ stat $_ ] ] } @sentinels;
    my @files = ls_files();
    Storable::nstore( [ [ @sentinels ] , [ @files ] ], $mtimes_path) or
	die "unable to store mtimes $!";
}

sub match_sentinel_data {
    local $_;
    my ($old, $new, $trustctime) = @_;
    if (!@$old) {
	return (@$new) ? undef : 1;
    } else {
	@$new or return undef;
    }
    # Skip hardlink count, atime, blksize
    for (0..2,4..7,9,10,12) {
	next if ($_ == 10 and ! $trustctime);
	$old->[$_] == $new->[$_] or return undef;
    }
    return 1;
}

sub needs_update {
    local $_;
    my ($old, $new) = @_;
    for (0..1) {
	$old->[$_] eq $new->[$_] or return undef;
    }
    for (2..4) {
	$old->[$_] == $new->[$_] or return undef;
    }
    $old->[5] != $new->[5];
}

sub restore {
    local $_;
    my $stored = Storable::retrieve($mtimes_path) or
	die "unable to load stored data";
    my $trustctime = get_config('--bool', 'core.trustctime');
    $trustctime = defined($trustctime) ? $trustctime eq 'true' : 1;
    my ($sentinels, $oldfiles) = @$stored;
    for (@$sentinels) {
	match_sentinel_data( [ stat($_->[0]) ], $_->[1], $trustctime) or
	    die "Unable to restore mtimes, stat data for sentinel '$_->[0]' does not match";
    }
    my @newfiles = ls_files(1);
    my ($i, $restored) = (0, 0);
    for (@$oldfiles) {
	while ($newfiles[$i]->[0] lt $_->[0] and $i < @newfiles) {
	    $i++;
	}
	if (needs_update($_, $newfiles[$i])) {
	    utime($newfiles[$i]->[6], $_->[5], $_->[0]);
	    $restored = 1;
	}
    }
    if ($restored) {
	print "restored mtimes\n";
    }
}

my $cmd = shift;
# Keep relative paths relative in case repository directory is renamed
# between saving and restoring mtimes.
if ($ENV{GIT_PREFIX}) {
    @ARGV = map {
	file_name_is_absolute($_) ? $_ : catfile($ENV{GIT_PREFIX}, $_);
    } @ARGV;
}
my $up = git(qw(rev-parse --show-cdup));
if ($up) {
    @ARGV = map {
	file_name_is_absolute($_) ? $_ : abs2rel(rel2abs($_), $up);
    } @ARGV;
    chdir $up;
}

my $tmp_index = catfile($GIT_DIR, "mtimes-index");
my $src_index = $ENV{GIT_INDEX_FILE} ? $ENV{GIT_INDEX_FILE} :
				       catfile($GIT_DIR, "index");
copy($src_index, $tmp_index) or
    die "cannot create temporary index '$tmp_index'\n";
$ENV{GIT_INDEX_FILE} = $tmp_index;
git(qw(add -u));

if ($cmd eq 'save') {
    save();
} elsif ($cmd eq 'restore' and ! @ARGV) {
    restore();
} else {
    print STDERR "usage: git mtimes <save [sentinels ...] | restore>\n";
}

END {
    unlink $tmp_index;
}

> I think that would fix the problem that our engineers run into and also 
> the problem that Linus experienced during the merge, wouldn't it?
> 
> Thanks,
> Lars
> 

