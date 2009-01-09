X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Minimum required version of subversion for git-svn?
Date: Fri, 9 Jan 2009 11:11:27 +0100
Message-ID: <496722CF.1060802@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 9 Jan 2009 10:21:55 +0000 (UTC)
To: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jan 2009 05:21:34 EST
User-Agent: Thunderbird 2.0.0.18 (X11/20081124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1LLEW3-0003Np-Vc for gcvg-git-2@gmane.org; Fri, 09 Jan 2009
 11:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754506AbZAIKVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jan 2009
 05:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753658AbZAIKVf
 (ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 05:21:35 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:22186 "EHLO
 sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S1753446AbZAIKVe (ORCPT <rfc822;git@vger.kernel.org>); Fri, 9
 Jan 2009 05:21:34 -0500
Received: from [130.225.25.159] (130.225.25.159) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.1.336.0; Fri, 9 Jan 2009 11:11:27 +0100
Sender: git-owner@vger.kernel.org

Hello,

With git 1.6.0.5 I was able to run git-svn with subversion 1.1.4 on
RHEL4/i386 but with 1.6.0.6 and 1.6.1 the testsuite now fails in the new
test t9104.10:
* FAIL 10: follow-parent is atomic

                 (
                         cd wc &&
                         svn up &&
                         svn mkdir stunk &&
                         echo "trunk stunk" > stunk/readme &&
                         svn add stunk/readme &&
                         svn ci -m "trunk stunk" &&
                         echo "stunk like junk" >> stunk/readme &&
                         svn ci -m "really stunk" &&
                         echo "stink stank stunk" >> stunk/readme &&
                         svn ci -m "even the grinch agrees"
                 ) &&
                 svn copy -m "stunk flunked" "$svnrepo"/stunk
"$svnrepo"/flunk &&
                 { svn cp -m "early stunk flunked too" \
                         "$svnrepo"/stunk@17 "$svnrepo"/flunked ||
                 svn cp -m "early stunk flunked too" \
                         -r17 "$svnrepo"/stunk "$svnrepo"/flunked; } &&
                 git svn init --minimize-url -i stunk "$svnrepo"/stunk &&
                 git svn fetch -i stunk &&
                 git update-ref refs/remotes/flunk@18
refs/remotes/stunk~2 &&
                 git update-ref -d refs/remotes/stunk &&
                 git config --unset svn-remote.svn.fetch stunk &&
                 mkdir -p "$GIT_DIR"/svn/flunk@18 &&
                 rev_map=$(cd "$GIT_DIR"/svn/stunk && ls .rev_map*) &&
                 dd if="$GIT_DIR"/svn/stunk/$rev_map \
                    of="$GIT_DIR"/svn/flunk@18/$rev_map bs=24 count=1 &&
                 rm -rf "$GIT_DIR"/svn/stunk &&
                 git svn init --minimize-url -i flunk "$svnrepo"/flunk &&
                 git svn fetch -i flunk &&
                 git svn init --minimize-url -i stunk "$svnrepo"/stunk &&
                 git svn fetch -i stunk &&
                 git svn init --minimize-url -i flunked
"$svnrepo"/flunked &&
                 git svn fetch -i flunked
                 test "`git rev-parse --verify refs/remotes/flunk@18`" \
                    = "`git rev-parse --verify refs/remotes/stunk`" &&
                 test "`git rev-parse --verify refs/remotes/flunk~1`" \
                    = "`git rev-parse --verify refs/remotes/stunk`" &&
                 test "`git rev-parse --verify refs/remotes/flunked~1`" \
                    = "`git rev-parse --verify refs/remotes/stunk~1`"


With 1.6.1 I also see t9129.10-12 failing with subversion 1.1.4:
* FAIL 10: ISO-8859-1 should match UTF-8 in svn

                 (
                         cd ISO-8859-1 &&
                         compare_svn_head_with
"$TEST_DIRECTORY"/t3900/1-UTF-8.txt
                 )

* FAIL 11: $H should match UTF-8 in svn

                         (
                                 cd $H &&
                                 compare_svn_head_with
"$TEST_DIRECTORY"/t3900/2-UTF-8.txt
                         )

* FAIL 12: $H should match UTF-8 in svn

                         (
                                 cd $H &&
                                 compare_svn_head_with
"$TEST_DIRECTORY"/t3900/2-UTF-8.txt
                         )

* failed 3 among 12 test(s)
make[2]: Leaving directory `/builddir/build/BUILD/git-1.6.1/t'
make[2]: *** [t9129-git-svn-i18n-commitencoding.sh] Error 1

I see in git-svn.perl that only SVN::Core 1.1.0 is required. Is it still
the intention that git-svn should work with subversion 1.1.x?

If you're going to bump the minimum requirement I would ask that you
atleast keep 1.3.x as supported. This is the last release of subversion
where RHEL3 can satisfy the dependencies out of the box and I've
verified that the testsuite will pass with 1.3.2.

-tgc
