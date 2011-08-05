From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: What you can throw (on a Friday)
Date: Fri, 5 Aug 2011 16:47:43 +0200
Message-ID: <20110805144743.GA41203@sherwood.local>
References: <7vliv93r9g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 16:47:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpLgo-0007Dr-Kp
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 16:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755650Ab1HEOru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 10:47:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37355 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942Ab1HEOrt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 10:47:49 -0400
Received: by fxh19 with SMTP id 19so2887294fxh.19
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 07:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=hNSB+89MMcm53ueI3+8JnIFC+KslKXDDDy4+PR3k9nE=;
        b=c+MfjXyGkvpvTW7aumXPOVOBZihCLGgjOu6T0vqzXITsZj35ajE/oMi95B+yjrOqPE
         ndMtprbJTo9x9SQDuv7lrufnFcaULjJ8ClP1NAHbjPGB/2tYLzRUiDMF/rDwCPyxfXOt
         Q9NzL6964n7euCdtHvRvOO0ckDDXZ+WuurUfQ=
Received: by 10.223.59.208 with SMTP id m16mr3019309fah.47.1312555667835;
        Fri, 05 Aug 2011 07:47:47 -0700 (PDT)
Received: from sherwood.local ([82.113.99.155])
        by mx.google.com with ESMTPS id q15sm2014431fah.32.2011.08.05.07.47.43
        (version=SSLv3 cipher=OTHER);
        Fri, 05 Aug 2011 07:47:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vliv93r9g.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178796>

@ Junio C Hamano <gitster@pobox.com> wrote (2011-08-04 21:34+0200):
> Noe Rubinstein <nrubinstein@proformatique.com> writes: [...]
> If a user fat-fingers an unnecessary [...]

Heh.  Note that one of the first mails i've received from this
list was the one which transported the annoyed gasp from
the-one-who-was-born-right-next-door-to-where-the-elks-live.
About scattered non-breaking spaces (U+A0).

Unfortunately that patch series has been thrown away!  And so
i think you underestimate the problem.  On my german keyboard,
f.e., i need to press ALT for all of these: []|{} (ALT + [5-9]).
!!!  Well, there *are* days where my thumb is fast enough to leave
ALT before i hit SPC ...  (But today it yet caused distress.)

After the second scissor i'll append my current pre-commit (and
thus pre-applypatch) (for nothing except to show that it's
a problem people really have to deal with).  But i already thought
about resurrecting your patch-series and reduce it to only the
whitespace check.  Because, being able to say

    exec git diff-index --check --cached $against --

instead would be much easier, because then you could simply state
and request from contributors "please adhere to the whitespace
policy of this project:"

    whitespace = trailing-space,tabwidth=4,tab-in-indent,yell-on-nbsp

> Hmm?

Well and while fooling around and getting more familiar with
git(1) i stumbled over some things which might be caused by bad
control flow instead of being desired behaviour.  After the first
scissor there is a test shell script which reproduces them.

Thanks for git(1) beside that, plastic dishes also break ...
Nice weekend all of you.

--Steffen
Ciao, sdaoden(*)(gmail.com)
ASCII ribbon campaign           ( ) More nuclear fission plants
  against HTML e-mail            X    can serve more coloured
    and proprietary attachments / \     and sounding animations

-- >8 --
#!/bin/sh

error() {
	echo >&2 Error: $*
}

add_file() {
    local f=$1
    echo $f > $f
    git add $f
    git commit -qm $f
}

origin() {
    rm -rf origin
    mkdir origin
    cd origin
    git init -q
    add_file eins
    add_file zwei
    add_file drei
    add_file vier
    add_file fuenf
    git checkout -qb devel
    add_file devel-one
    add_file devel-two
    git checkout -q master
    git tag -m vT1 vT1 HEAD
    cd ..
}

badbad_tagopt() {
    echo
    echo
    echo '1. echo git fetch will --prune away branches if --tags is set'
    echo '   (even if done so through remote.XY.tagopt config).'
    echo '   But nice: it works well again if --all is also given.'
    echo
	work() {
        echo - Am using fetch -q --prune $1 $2
		rm -rf tr1
		mkdir tr1
		cd tr1
		git init -q
		git remote add -t master -t devel -m master origin ../origin

		git fetch -q --prune $1 $2

		git branch -a | grep -F 'origin/master' || error no master branch
		git branch -a | grep -F 'origin/devel' || error no devel branch
		cd ..
		rm -rf tr1
	}


	work '' ''
	work '--tags' ''
    work '--tags' '--all'
}

lazy_ref() {
    echo
    echo
    echo 2. If you do drop/there is no remote.XY.fetch of a branch,
    echo '   but configure the remote.XY.push entry, then after'
    echo '   git push the local ref is not updated, even though'
    echo '   the push succeeded and correctly updated the target repo.'
    echo
	work() {
        echo - remote.origin.fetch will include devel branch: $#
        cp -R origin origin.save
		rm -rf tr1
		mkdir tr1
		cd tr1
		git init -q
		git remote add -t master -m master -t devel origin ../origin
        git config --local remote.origin.push \
                           +refs/heads/master:refs/heads/master
        git config --local --add remote.origin.push \
                            +refs/heads/devel:refs/heads/devel
		git fetch -q --prune
        git checkout -q master
        git checkout -q devel
        add_file test-repo-devel-branch-file

        test $# == 0 &&
            git config --local --replace-all remote.origin.fetch \
                                 +refs/heads/master:refs/remotes/origin/master
        git push -q origin

        x=$(git show-ref --hash devel | sort -u | awk '{++l} END {print l}')
        test $x == 1 || error 'local-ref mismatch'
		cd ..
		rm -rf tr1 origin
        mv origin.save origin
	}

	work YesPlease
	work
}

cd $TMPDIR
mkdir workdir
cd workdir

origin

badbad_tagopt
lazy_ref

cd ..
rm -rf workdir
exit 0
-- >8 --
#!/bin/sh
#@ git(1) pre-commit hook for dummies

#if git rev-parse --verify HEAD >/dev/null 2>&1
#then
    against=HEAD
#else
    # Initial commit: diff against an empty tree object
#   against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
#fi

# Oh no, unfortunately not: exec git diff-index --check --cached $against --
git diff --cached $against | perl -e '
    # XXX 1st version, may not be able to swallow all possible diff output yet
    my ($estat, $l, $fname) = (0, undef, undef);

    for (;;) { last if stdin() =~ /^diff/o; }
    for (;;) { head(); hunk(); }

    sub stdin {
        $l = <STDIN>;
        exit($estat) unless $l;
        chomp($l);
        return $l;
    }

    sub head {
        # Skip anything, including options and entire rename and delete diffs,
        # until we see the ---/+++ line pair
        for (;;) {
            last if $l =~ /^---/o;
            stdin();
        }

        stdin();
        die "head, 1.: cannot parse diff!" unless $l =~ /^\+\+\+ /o;
        $fname = substr($l, 4);
        $fname = substr($fname, 2) if $fname =~ /^b\//o;
    }

    sub hunk() {
        stdin();
        die "hunk, 1.: cannot parse diff!" unless $l =~ /^@@ /o;
JHUNK:
        # regex shamelessly stolen from git(1), and modified
        $l =~ /^@@ -\d+(?:,\d+)? \+(\d+)(?:,\d+)? @@/;
        my $lno = $1 - 1;

        for (;;) {
            stdin();
            return if $l =~ /^diff/o;       # Different file?
            goto JHUNK if $l =~ /^@@ /o;    # Same file, different hunk?
            next if $l =~ /^-/o;            # Ignore removals

            ++$lno;
            next if $l =~ /^ /o;
            $l = substr($l, 1);

            if (index($l, "\xA0") != -1) {
                $estat = 1;
                print "$fname:$lno: non-breaking space (NBSP, U+A0).\n";
            }
            if ($l =~ /\s+$/o) {
                $estat = 1;
                print "$fname:$lno: trailing whitespace.\n";
            }
            if ($l =~ /^(\s+)/o && $1 =~ /\x09/o) {
                $estat = 1;
                print "$fname:$lno: tabulator in indent.\n";
            }
        }
    }
    '
