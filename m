From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: 195b7ca6 breaks t9010 at current master
Date: Tue, 29 Mar 2011 04:08:36 +0200
Message-ID: <AANLkTik0CNXY9bKGOa9Xmai_OPQgExfLsFs1yN2pCVr8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 04:08:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4OMO-0006EQ-Dw
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 04:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233Ab1C2CIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2011 22:08:39 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52515 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab1C2CIi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 22:08:38 -0400
Received: by vws1 with SMTP id 1so2815344vws.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 19:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nAb82OQGei45phLgwjuXZihOwFSVoo/x4bTNAcpNLCg=;
        b=l/1BFwHem0gtNzwN3EEdptIPx4tRwqFLH4GOLhCH7QWhchS38EF2Ag0jXsBb6gdl5P
         SpU6z+O1mioU0J1jlnBqZHooXh9ul43kbOkBkqdhErClgSg1W9cexQwh+5VMJXXfxgfM
         D77p5JIxEuP4JU1SKpKvnvEYSS3CP7Ylzjg6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        b=OWOP3t1J0p52vQF7EyDw5AE5W5rABwqsmnffECYs01v/PhrpGvmL4IHhEAbNpWndVv
         QdGsAWFHSQjp1SqhORUmjskpwSu4KOvoD3fxNb2hZ6PJJMLZXVKfkW/fJT5owusmTF29
         wnpUBEgfNtWCF6edfcZvZFYMVKekZsw9bGQDE=
Received: by 10.52.171.111 with SMTP id at15mr6639571vdc.167.1301364516955;
 Mon, 28 Mar 2011 19:08:36 -0700 (PDT)
Received: by 10.52.168.3 with HTTP; Mon, 28 Mar 2011 19:08:36 -0700 (PDT)
X-Google-Sender-Auth: qUDZoacGh9H6EohBPqNJ2b8x87k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170217>

When running "make test" at current master (v1.7.4.2-406-gbe919d5),
t9010-svn-fe.sh fails. Bisecting shows that 195b7ca6 ("vcs-svn: handle
log message with embedded NUL") breaks the test. The test runs fine
after 195b7ca6 is reverted. These tests succeeds without the commit, bu=
t
fails when it=E2=80=99s applied:

  - empty properties
  - author name and commit message
  - unsupported properties are ignored
  - directory with files
  - NUL in property value
  - change file mode and reiterate content
  - property deltas supported
  - properties on /
  - deltas for typechange
  - t9135/svn.dump

In addition, this test introduced in 195b7ca6 fails:

  - NUL in log message, file content, and property name

Tested on four different Linux systems (two with the same Ubuntu
version), all with the same result. Tested with default Makefile and
also "make configure".

System info:

  Ubuntu 10.04.2 LTS
    gcc (Ubuntu 4.4.3-4ubuntu5) 4.4.3
    svn, version 1.6.6 (r40053)

  DebianEdu/Skolelinux (terra) (Based on Debian release 5.0.8, lenny)
    gcc (Debian 4.3.2-1.1) 4.3.2
    svn, version 1.5.1 (r32289)

  Debian GNU/Linux 5.0.8 (lenny)
    gcc (Debian 4.3.2-1.1) 4.3.2
    svn, version 1.5.1 (r32289)

Output from t9010-svn-fe.sh at current master (v1.7.4.2-406-gbe919d5):

  ok 93 - --force sends cover letter template anyway
  # passed all 93 test(s)
  1..93
  *** t9010-svn-fe.sh ***
  ok 1 - empty dump
  ok 2 - v4 dumps not supported
  not ok 3 - empty revision # TODO known breakage
  not ok - 4 empty properties
  #
  #               reinit_git &&
  #               printf "rev <nobody, nobody@local>: %s
  #       " "" "" >expect &&
  #               cat >emptyprop.dump <<-\EOF &&
  #               SVN-fs-dump-format-version: 3
  #
  #               Revision-number: 1
  #               Prop-content-length: 10
  #               Content-length: 10
  #
  #               PROPS-END
  #
  #               Revision-number: 2
  #               Prop-content-length: 10
  #               Content-length: 10
  #
  #               PROPS-END
  #               EOF
  #               test-svn-fe emptyprop.dump >stream &&
  #               git fast-import <stream &&
  #               git log -p --format=3D"rev <%an, %ae>: %s" HEAD >actu=
al &&
  #               test_cmp expect actual
  #
  not ok - 5 author name and commit message
  #
  #               reinit_git &&
  #               echo "<author@example.com,
author@example.com@local>" >expect.author &&
  #               cat >message <<-\EOF &&
  #               A concise summary of the change
  #
  #               A detailed description of the change, why it is neede=
d, what
  #               was broken and why applying this is the best course o=
f action.
  #
  #               * file.c
  #                   Details pertaining to an individual file.
  #               EOF
  #               {
  #                       properties \
  #                               svn:author author@example.com \
  #                               svn:log "$(cat message)" &&
  #                       echo PROPS-END
  #               } >props &&
  #               {
  #                       echo "SVN-fs-dump-format-version: 3" &&
  #                       echo &&
  #                       echo "Revision-number: 1" &&
  #                       echo Prop-content-length: $(wc -c <props) &&
  #                       echo Content-length: $(wc -c <props) &&
  #                       echo &&
  #                       cat props
  #               } >log.dump &&
  #               test-svn-fe log.dump >stream &&
  #               git fast-import <stream &&
  #               git log -p --format=3D"%B" HEAD >actual.log &&
  #               git log --format=3D"<%an, %ae>" >actual.author &&
  #               test_cmp message actual.log &&
  #               test_cmp expect.author actual.author
  #
  not ok - 6 unsupported properties are ignored
  #
  #               reinit_git &&
  #               echo author >expect &&
  #               cat >extraprop.dump <<-\EOF &&
  #               SVN-fs-dump-format-version: 3
  #
  #               Revision-number: 1
  #               Prop-content-length: 56
  #               Content-length: 56
  #
  #               K 8
  #               nonsense
  #               V 1
  #               y
  #               K 10
  #               svn:author
  #               V 6
  #               author
  #               PROPS-END
  #               EOF
  #               test-svn-fe extraprop.dump >stream &&
  #               git fast-import <stream &&
  #               git log -p --format=3D%an HEAD >actual &&
  #               test_cmp expect actual
  #
  not ok 7 - timestamp and empty file # TODO known breakage
  not ok - 8 directory with files
  #
  #               reinit_git &&
  #               printf "%s
  #       " directory/file1 directory/file2 >expect.files &&
  #               echo hi >hi &&
  #               echo hello >hello &&
  #               {
  #                       properties \
  #                               svn:author author@example.com \
  #                               svn:date "1999-02-01T00:01:002.000000=
Z" \
  #                               svn:log "add directory with some
files in it" &&
  #                       echo PROPS-END
  #               } >props &&
  #               {
  #                       cat <<-EOF &&
  #                       SVN-fs-dump-format-version: 3
  #
  #                       Revision-number: 1
  #                       EOF
  #                       echo Prop-content-length: $(wc -c <props) &&
  #                       echo Content-length: $(wc -c <props) &&
  #                       echo &&
  #                       cat props &&
  #                       cat <<-\EOF &&
  #
  #                       Node-path: directory
  #                       Node-kind: dir
  #                       Node-action: add
  #                       Prop-content-length: 10
  #                       Content-length: 10
  #
  #                       PROPS-END
  #
  #                       Node-path: directory/file1
  #                       Node-kind: file
  #                       Node-action: add
  #                       EOF
  #                       text_no_props hello &&
  #                       cat <<-\EOF &&
  #                       Node-path: directory/file2
  #                       Node-kind: file
  #                       Node-action: add
  #                       EOF
  #                       text_no_props hi
  #               } >directory.dump &&
  #               test-svn-fe directory.dump >stream &&
  #               git fast-import <stream &&
  #
  #               git ls-tree -r --name-only HEAD >actual.files &&
  #               git checkout HEAD directory &&
  #               test_cmp expect.files actual.files &&
  #               test_cmp hello directory/file1 &&
  #               test_cmp hi directory/file2
  #
  ok 9 - node without action
  ok 10 - action: add node without text
  not ok 11 - change file mode but keep old content # TODO known breaka=
ge
  not ok - 12 NUL in property value
  #
  #               reinit_git &&
  #               echo "commit message" >expect.message &&
  #               {
  #                       properties \
  #                               unimportant "something with a NUL (Q)=
" \
  #                               svn:log "commit message"&&
  #                       echo PROPS-END
  #               } |
  #               q_to_nul >props &&
  #               {
  #                       cat <<-\EOF &&
  #                       SVN-fs-dump-format-version: 3
  #
  #                       Revision-number: 1
  #                       EOF
  #                       echo Prop-content-length: $(wc -c <props) &&
  #                       echo Content-length: $(wc -c <props) &&
  #                       echo &&
  #                       cat props
  #               } >nulprop.dump &&
  #               test-svn-fe nulprop.dump >stream &&
  #               git fast-import <stream &&
  #               git diff-tree --always -s --format=3D%s HEAD >actual.=
message &&
  #               test_cmp expect.message actual.message
  #
  not ok - 13 NUL in log message, file content, and property name
  #
  #               # Caveat: svnadmin 1.6.16 (r1073529) truncates at
  not ok - 14 change file mode and reiterate content
  #
  #               reinit_git &&
  #               cat >expect <<-\EOF &&
  #               OBJID
  #               :120000 100644 OBJID OBJID T    greeting
  #               OBJID
  #               :100644 120000 OBJID OBJID T    greeting
  #               OBJID
  #               :000000 100644 OBJID OBJID A    greeting
  #               EOF
  #               echo "link hello" >expect.blob &&
  #               echo hello >hello &&
  #               cat >filemode.dump <<-\EOF &&
  #               SVN-fs-dump-format-version: 3
  #
  #               Revision-number: 1
  #               Prop-content-length: 10
  #               Content-length: 10
  #
  #               PROPS-END
  #
  #               Node-path: greeting
  #               Node-kind: file
  #               Node-action: add
  #               Prop-content-length: 10
  #               Text-content-length: 11
  #               Content-length: 21
  #
  #               PROPS-END
  #               link hello
  #
  #               Revision-number: 2
  #               Prop-content-length: 10
  #               Content-length: 10
  #
  #               PROPS-END
  #
  #               Node-path: greeting
  #               Node-kind: file
  #               Node-action: change
  #               Prop-content-length: 33
  #               Text-content-length: 11
  #               Content-length: 44
  #
  #               K 11
  #               svn:special
  #               V 1
  #               *
  #               PROPS-END
  #               link hello
  #
  #               Revision-number: 3
  #               Prop-content-length: 10
  #               Content-length: 10
  #
  #               PROPS-END
  #
  #               Node-path: greeting
  #               Node-kind: file
  #               Node-action: change
  #               Prop-content-length: 10
  #               Text-content-length: 11
  #               Content-length: 21
  #
  #               PROPS-END
  #               link hello
  #               EOF
  #               test-svn-fe filemode.dump >stream &&
  #               git fast-import <stream &&
  #               {
  #                       git rev-list HEAD |
  #                       git diff-tree --root --stdin |
  #                       sed "s/$_x40/OBJID/g"
  #               } >actual &&
  #               git show HEAD:greeting >actual.blob &&
  #               git show HEAD^:greeting >actual.target &&
  #               test_cmp expect actual &&
  #               test_cmp expect.blob actual.blob &&
  #               test_cmp hello actual.target
  #
  ok 15 - deltas not supported
  not ok - 16 property deltas supported
  #
  #               reinit_git &&
  #               cat >expect <<-\EOF &&
  #               OBJID
  #               :100755 100644 OBJID OBJID M    script.sh
  #               EOF
  #               {
  #                       properties \
  #                               svn:author author@example.com \
  #                               svn:date "1999-03-06T00:01:002.000000=
Z" \
  #                               svn:log "make an executable, or
chmod -x it" &&
  #                       echo PROPS-END
  #               } >revprops &&
  #               {
  #                       echo SVN-fs-dump-format-version: 3 &&
  #                       echo &&
  #                       echo Revision-number: 1 &&
  #                       echo Prop-content-length: $(wc -c <revprops) =
&&
  #                       echo Content-length: $(wc -c <revprops) &&
  #                       echo &&
  #                       cat revprops &&
  #                       echo &&
  #                       cat <<-\EOF &&
  #                       Node-path: script.sh
  #                       Node-kind: file
  #                       Node-action: add
  #                       Text-content-length: 0
  #                       Prop-content-length: 39
  #                       Content-length: 39
  #
  #                       K 14
  #                       svn:executable
  #                       V 4
  #                       true
  #                       PROPS-END
  #
  #                       EOF
  #                       echo Revision-number: 2 &&
  #                       echo Prop-content-length: $(wc -c <revprops) =
&&
  #                       echo Content-length: $(wc -c <revprops) &&
  #                       echo &&
  #                       cat revprops &&
  #                       echo &&
  #                       cat <<-\EOF
  #                       Node-path: script.sh
  #                       Node-kind: file
  #                       Node-action: change
  #                       Prop-delta: true
  #                       Prop-content-length: 30
  #                       Content-length: 30
  #
  #                       D 14
  #                       svn:executable
  #                       PROPS-END
  #                       EOF
  #               } >propdelta.dump &&
  #               test-svn-fe propdelta.dump >stream &&
  #               git fast-import <stream &&
  #               {
  #                       git rev-list HEAD |
  #                       git diff-tree --stdin |
  #                       sed "s/$_x40/OBJID/g"
  #               } >actual &&
  #               test_cmp expect actual
  #
  not ok - 17 properties on /
  #
  #               reinit_git &&
  #               cat <<-\EOF >expect &&
  #               OBJID
  #               OBJID
  #               :000000 100644 OBJID OBJID A    greeting
  #               EOF
  #               sed -e "s/X$//" <<-\EOF >changeroot.dump &&
  #               SVN-fs-dump-format-version: 3
  #
  #               Revision-number: 1
  #               Prop-content-length: 10
  #               Content-length: 10
  #
  #               PROPS-END
  #
  #               Node-path: greeting
  #               Node-kind: file
  #               Node-action: add
  #               Text-content-length: 0
  #               Prop-content-length: 10
  #               Content-length: 10
  #
  #               PROPS-END
  #
  #               Revision-number: 2
  #               Prop-content-length: 10
  #               Content-length: 10
  #
  #               PROPS-END
  #
  #               Node-path: X
  #               Node-kind: dir
  #               Node-action: change
  #               Prop-delta: true
  #               Prop-content-length: 43
  #               Content-length: 43
  #
  #               K 10
  #               svn:ignore
  #               V 11
  #               build-area
  #
  #               PROPS-END
  #               EOF
  #               test-svn-fe changeroot.dump >stream &&
  #               git fast-import <stream &&
  #               {
  #                       git rev-list HEAD |
  #                       git diff-tree --root --always --stdin |
  #                       sed "s/$_x40/OBJID/g"
  #               } >actual &&
  #               test_cmp expect actual
  #
  not ok - 18 deltas for typechange
  #
  #               reinit_git &&
  #               cat >expect <<-\EOF &&
  #               OBJID
  #               :120000 100644 OBJID OBJID T    test-file
  #               OBJID
  #               :100755 120000 OBJID OBJID T    test-file
  #               OBJID
  #               :000000 100755 OBJID OBJID A    test-file
  #               EOF
  #               cat >deleteprop.dump <<-\EOF &&
  #               SVN-fs-dump-format-version: 3
  #
  #               Revision-number: 1
  #               Prop-content-length: 10
  #               Content-length: 10
  #
  #               PROPS-END
  #
  #               Node-path: test-file
  #               Node-kind: file
  #               Node-action: add
  #               Prop-delta: true
  #               Prop-content-length: 35
  #               Text-content-length: 17
  #               Content-length: 52
  #
  #               K 14
  #               svn:executable
  #               V 0
  #
  #               PROPS-END
  #               link testing 123
  #
  #               Revision-number: 2
  #               Prop-content-length: 10
  #               Content-length: 10
  #
  #               PROPS-END
  #
  #               Node-path: test-file
  #               Node-kind: file
  #               Node-action: change
  #               Prop-delta: true
  #               Prop-content-length: 53
  #               Text-content-length: 17
  #               Content-length: 70
  #
  #               K 11
  #               svn:special
  #               V 1
  #               *
  #               D 14
  #               svn:executable
  #               PROPS-END
  #               link testing 231
  #
  #               Revision-number: 3
  #               Prop-content-length: 10
  #               Content-length: 10
  #
  #               PROPS-END
  #
  #               Node-path: test-file
  #               Node-kind: file
  #               Node-action: change
  #               Prop-delta: true
  #               Prop-content-length: 27
  #               Text-content-length: 17
  #               Content-length: 44
  #
  #               D 11
  #               svn:special
  #               PROPS-END
  #               link testing 321
  #               EOF
  #               test-svn-fe deleteprop.dump >stream &&
  #               git fast-import <stream &&
  #               {
  #                       git rev-list HEAD |
  #                       git diff-tree --root --stdin |
  #                       sed "s/$_x40/OBJID/g"
  #               } >actual &&
  #               test_cmp expect actual
  #
  ok 19 - set up svn repo
  not ok - 20 t9135/svn.dump
  #
  #               git init simple-git &&
  #               test-svn-fe "$TEST_DIRECTORY/t9135/svn.dump" >simple.=
fe &&
  #               (
  #                       cd simple-git &&
  #                       git fast-import <../simple.fe
  #               ) &&
  #               (
  #                       cd simple-svnco &&
  #                       git init &&
  #                       git add . &&
  #                       git fetch ../simple-git master &&
  #                       git diff --exit-code FETCH_HEAD
  #               )
  #
  # still have 3 known breakage(s)
  # failed 11 among remaining 17 test(s)
  1..20
  make[2]: *** [t9010-svn-fe.sh] Error 1
  make[2]: Leaving directory `/home/sunny/src/other/git/build-git/t'
  make[1]: *** [test] Error 2
  make[1]: Leaving directory `/home/sunny/src/other/git/build-git/t'
  make: *** [test] Error 2

Also posted at https://gist.github.com/891690 in case Gmail messes up
the formatting.

Regards,
=C3=98yvind
