Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A844C2BA80
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1401520768
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgDGQex (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:34:53 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:10870 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgDGQex (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 12:34:53 -0400
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
        by smtp3-g21.free.fr (Postfix) with ESMTP id 3D8E413F8FE
        for <git@vger.kernel.org>; Tue,  7 Apr 2020 18:34:51 +0200 (CEST)
Date:   Tue, 7 Apr 2020 18:34:51 +0200 (CEST)
From:   ydirson@free.fr
To:     git <git@vger.kernel.org>
Message-ID: <277700231.805340039.1586277291215.JavaMail.root@zimbra39-e7>
In-Reply-To: <702823257.805273759.1586276452976.JavaMail.root@zimbra39-e7>
Subject: [BUG] submodule move badly handled by git-rebase
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_805340037_822914629.1586277291214"
X-Originating-IP: [91.170.159.152]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

------=_Part_805340037_822914629.1586277291214
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello all,

When rebasing commits involving move of a submodule, git-rebase fails to
record in index the "add" part of the rename.  This leaves the workdir
dirty and the rebase gets stopped.

fast-export of a testcase is attached.  To reproduce, just 
"git rebase -i", add a "break" before the move commit,
use this to introduce some noise, and watch.

Best regards,
-- 
Yann


(master)$ git rebase -i HEAD^^
hint: Waiting for your editor to close the file... Waiting for Emacs...
Stopped at b0e1b00... add submodule

(master|REBASE 2/3)$ echo >>README 

(master|REBASE 2/3)$ git commit -a -m noise
[detached HEAD d67c886] noise
 1 file changed, 1 insertion(+)

(master|REBASE 2/3)$ git rebase --continue 
Adding as subdir/gitlab-oe~08e230f... move submodule instead
error: could not apply 08e230f... move submodule
Resolve all conflicts manually, mark them as resolved with
"git add/rm <conflicted_files>", then run "git rebase --continue".
You can instead skip this commit: run "git rebase --skip".
To abort and get back to the state before "git rebase", run "git rebase --abort".
Could not apply 08e230f... move submodule

(master|REBASE 3/3)$ git st
interactive rebase in progress; onto c21ef8e
Last commands done (3 commands done):
   break
   pick 08e230f move submodule
  (see more in file .git/rebase-merge/done)
No commands remaining.
You are currently rebasing branch 'master' on 'c21ef8e'.
  (fix conflicts and then run "git rebase --continue")
  (use "git rebase --skip" to skip this patch)
  (use "git rebase --abort" to check out the original branch)

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   .gitmodules
        deleted:    gitlab-oe

Unmerged paths:
  (use "git restore --staged <file>..." to unstage)
  (use "git add <file>..." to mark resolution)
        added by them:   subdir/gitlab-oe

(master|REBASE 3/3)$ 
------=_Part_805340037_822914629.1586277291214
Content-Type: application/octet-stream; name=submodule-move.fexp
Content-Disposition: attachment; filename=submodule-move.fexp
Content-Transfer-Encoding: base64

YmxvYgptYXJrIDoxCmRhdGEgNApmb28KCnJlc2V0IHJlZnMvaGVhZHMvbWFzdGVyCmNvbW1pdCBy
ZWZzL2hlYWRzL21hc3RlcgptYXJrIDoyCmF1dGhvciBZYW5uIERpcnNvbiA8eWFubkBibGFkZS1n
cm91cC5jb20+IDE1ODYyNzYyNTUgKzAyMDAKY29tbWl0dGVyIFlhbm4gRGlyc29uIDx5YW5uQGJs
YWRlLWdyb3VwLmNvbT4gMTU4NjI3NjI1NSArMDIwMApkYXRhIDgKaW5pdGlhbApNIDEwMDY0NCA6
MSBSRUFETUUKCmJsb2IKbWFyayA6MwpkYXRhIDkzCltzdWJtb2R1bGUgImdpdGxhYi1vZSJdCglw
YXRoID0gZ2l0bGFiLW9lCgl1cmwgPSBodHRwczovL2dpdGh1Yi5jb20vQmxhZGVHcm91cC9naXRs
YWItb2UuZ2l0Cgpjb21taXQgcmVmcy9oZWFkcy9tYXN0ZXIKbWFyayA6NAphdXRob3IgWWFubiBE
aXJzb24gPHlhbm5AYmxhZGUtZ3JvdXAuY29tPiAxNTg2Mjc2Mjk3ICswMjAwCmNvbW1pdHRlciBZ
YW5uIERpcnNvbiA8eWFubkBibGFkZS1ncm91cC5jb20+IDE1ODYyNzYyOTcgKzAyMDAKZGF0YSAx
NAphZGQgc3VibW9kdWxlCmZyb20gOjIKTSAxMDA2NDQgOjMgLmdpdG1vZHVsZXMKTSAxNjAwMDAg
ZGQ5NDNkYzZjOTc2NjRkNDA5ZmVhYWZmMzY0N2MyNDJkYmIzMDBkZiBnaXRsYWItb2UKCmJsb2IK
bWFyayA6NQpkYXRhIDEwMApbc3VibW9kdWxlICJnaXRsYWItb2UiXQoJcGF0aCA9IHN1YmRpci9n
aXRsYWItb2UKCXVybCA9IGh0dHBzOi8vZ2l0aHViLmNvbS9CbGFkZUdyb3VwL2dpdGxhYi1vZS5n
aXQKCmNvbW1pdCByZWZzL2hlYWRzL21hc3RlcgptYXJrIDo2CmF1dGhvciBZYW5uIERpcnNvbiA8
eWFubkBibGFkZS1ncm91cC5jb20+IDE1ODYyNzYzMjggKzAyMDAKY29tbWl0dGVyIFlhbm4gRGly
c29uIDx5YW5uQGJsYWRlLWdyb3VwLmNvbT4gMTU4NjI3NjMyOCArMDIwMApkYXRhIDE1Cm1vdmUg
c3VibW9kdWxlCmZyb20gOjQKTSAxMDA2NDQgOjUgLmdpdG1vZHVsZXMKRCBnaXRsYWItb2UKTSAx
NjAwMDAgZGQ5NDNkYzZjOTc2NjRkNDA5ZmVhYWZmMzY0N2MyNDJkYmIzMDBkZiBzdWJkaXIvZ2l0
bGFiLW9lCgo=
------=_Part_805340037_822914629.1586277291214--
