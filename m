From: Michael Blume <blume.mike@gmail.com>
Subject: Re: mac test failure -- test 3301
Date: Mon, 10 Nov 2014 16:46:45 -0800
Message-ID: <CAO2U3QidAQfXBOEuYsXnZ13DtVtW42mN+9k+8Miw9vy1gN1s0Q@mail.gmail.com>
References: <CAO2U3QhiWVvVKivBhE5R2xhjf8SPPtg6VSaQMxw7vbm_454jBQ@mail.gmail.com>
 <CAO2U3QgS+wDSSn0X1ThHtjLbuJJ7NTBMyJG6rUvHe+UFbibNdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 01:47:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnzc0-0007MW-TB
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 01:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbaKKArI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 19:47:08 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:37881 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbaKKArH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 19:47:07 -0500
Received: by mail-ob0-f179.google.com with SMTP id m8so6604082obr.24
        for <git@vger.kernel.org>; Mon, 10 Nov 2014 16:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=r5KUWf00XzqkqTVTijLCcbuw61poCugOq1WlADLlWB0=;
        b=ppNRlAaBd1al8bu4kvaa23oqZsodjTyr333vgijpP6tFPOQHx/aJQlTaalsu4beXQ2
         MSvx37hPSJyiwoddoV9TX0bfzVI5VN3kGudOWEikUHOtd4dDZi5YC6IclniHGk+jQEHj
         DT0SXBre1Gmn/KNiCXlc87b0/VkhgEBStlf3ddLMZfXDptqu5A4ETBTYdrYo+nMJIUtC
         IPKRpcSpy+IUrAgrSzgYP+0BkIXse0FsTF6uffw1LsJ7BzcZpHnv4EvHzUMEA5P23+nm
         0LF6ciIrp8cG9hwtzghHaWBvQZr/fnxHHM8mqeS0IRSzQzXFI0ofthXHB9nvmG0d7wa9
         KBxQ==
X-Received: by 10.182.142.70 with SMTP id ru6mr29108338obb.11.1415666825647;
 Mon, 10 Nov 2014 16:47:05 -0800 (PST)
Received: by 10.202.18.132 with HTTP; Mon, 10 Nov 2014 16:46:45 -0800 (PST)
In-Reply-To: <CAO2U3QgS+wDSSn0X1ThHtjLbuJJ7NTBMyJG6rUvHe+UFbibNdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

my first thought was that this might be a bash versioning issue, since
the commit in question basically refactors the script, and macs ship
with an archaic version of bash, but I have the same problem with bash
4.3.30

On Mon, Nov 10, 2014 at 4:23 PM, Michael Blume <blume.mike@gmail.com> wrote:
> (to be clear: I ran git bisect, and traced the problem to the modernize commit)
>
> On Mon, Nov 10, 2014 at 4:17 PM, Michael Blume <blume.mike@gmail.com> wrote:
>> the commit modernizing test 3301
>> (https://github.com/git/git/commit/fbe4f74865acfd) appears to break it
>> on my mac
>>
>> Verbose output follows:
>>
>> $ ./t3301-notes.sh -v
>> Initialized empty Git repository in
>> /Users/michael.blume/workspace/git/t/trash directory.t3301-notes/.git/
>> expecting success:
>> test_must_fail env MSG=3 git notes add
>>
>> fatal: Failed to resolve 'HEAD' as a valid ref.
>> ok 1 - cannot annotate non-existing HEAD
>>
>> expecting success:
>> test_commit 1st &&
>> test_commit 2nd
>>
>> [master (root-commit) 04ed9a0] 1st
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 1st.t
>> [master 7a4ca6e] 2nd
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 2nd.t
>> ok 2 - setup
>>
>> expecting success:
>> test_must_fail env MSG=1 GIT_NOTES_REF=/ git notes show &&
>> test_must_fail env MSG=2 GIT_NOTES_REF=/ git notes show
>>
>> fatal: Refusing to show notes in / (outside of refs/notes/)
>> fatal: Refusing to show notes in / (outside of refs/notes/)
>> ok 3 - need valid notes ref
>>
>> expecting success:
>> test_must_fail env MSG=1 GIT_NOTES_REF=refs/heads/bogus git notes add
>>
>> fatal: Refusing to add notes in refs/heads/bogus (outside of refs/notes/)
>> ok 4 - refusing to add notes in refs/heads/
>>
>> expecting success:
>> test_must_fail env MSG=1 GIT_NOTES_REF=refs/heads/bogus git notes edit
>>
>> fatal: Refusing to edit notes in refs/heads/bogus (outside of refs/notes/)
>> ok 5 - refusing to edit notes in refs/remotes/
>>
>> expecting success:
>> test_expect_code 1 git notes show
>>
>> error: No note found for object 7a4ca6ee52a974a66cbaa78e33214535dff1d691.
>> ok 6 - handle empty notes gracefully
>>
>> expecting success:
>> test_write_lines A B >expect &&
>> git show -s --format="A%n%NB" >output &&
>> test_cmp expect output
>>
>> ok 7 - show non-existent notes entry with %N
>>
>> expecting success:
>> MSG=b4 git notes add &&
>> test_path_is_missing .git/NOTES_EDITMSG &&
>> test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
>> test "b4" = "$(git notes show)" &&
>> git show HEAD^ &&
>> test_must_fail git notes show HEAD^
>>
>> b4
>> not ok 8 - create notes
>> #
>> # MSG=b4 git notes add &&
>> # test_path_is_missing .git/NOTES_EDITMSG &&
>> # test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
>> # test "b4" = "$(git notes show)" &&
>> # git show HEAD^ &&
>> # test_must_fail git notes show HEAD^
>> #
>>
>> expecting success:
>> test_write_lines A b4 B >expect &&
>> git show -s --format="A%n%NB" >output &&
>> test_cmp expect output
>>
>> ok 9 - show notes entry with %N
>>
>> expecting success:
>> cat <<-EOF >expect &&
>> a1d8fa6 refs/notes/commits@{0}: notes: Notes added by 'git notes add'
>> EOF
>> git reflog show refs/notes/commits >output &&
>> test_cmp expect output
>>
>> ok 10 - create reflog entry
>>
>> expecting success:
>> MSG=b3 git notes edit &&
>> test_path_is_missing .git/NOTES_EDITMSG &&
>> test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
>> test "b3" = "$(git notes show)" &&
>> git show HEAD^ &&
>> test_must_fail git notes show HEAD^
>>
>> b3
>> not ok 11 - edit existing notes
>> #
>> # MSG=b3 git notes edit &&
>> # test_path_is_missing .git/NOTES_EDITMSG &&
>> # test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
>> # test "b3" = "$(git notes show)" &&
>> # git show HEAD^ &&
>> # test_must_fail git notes show HEAD^
>> #
>>
>> expecting success:
>> test_must_fail git notes add -m "b2" &&
>> test_path_is_missing .git/NOTES_EDITMSG &&
>> test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
>> test "b3" = "$(git notes show)" &&
>> git show HEAD^ &&
>> test_must_fail git notes show HEAD^
>>
>> error: Cannot add notes. Found existing notes for object
>> 7a4ca6ee52a974a66cbaa78e33214535dff1d691. Use '-f' to overwrite
>> existing notes
>> not ok 12 - cannot "git notes add -m" where notes already exists
>> #
>> # test_must_fail git notes add -m "b2" &&
>> # test_path_is_missing .git/NOTES_EDITMSG &&
>> # test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
>> # test "b3" = "$(git notes show)" &&
>> # git show HEAD^ &&
>> # test_must_fail git notes show HEAD^
>> #
>>
>> expecting success:
>> git notes add -f -m "b1" &&
>> test_path_is_missing .git/NOTES_EDITMSG &&
>> test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
>> test "b1" = "$(git notes show)" &&
>> git show HEAD^ &&
>> test_must_fail git notes show HEAD^
>>
>> Overwriting existing notes for object 7a4ca6ee52a974a66cbaa78e33214535dff1d691
>> not ok 13 - can overwrite existing note with "git notes add -f -m"
>> #
>> # git notes add -f -m "b1" &&
>> # test_path_is_missing .git/NOTES_EDITMSG &&
>> # test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
>> # test "b1" = "$(git notes show)" &&
>> # git show HEAD^ &&
>> # test_must_fail git notes show HEAD^
>> #
>>
>> expecting success:
>> MSG=b2 git notes add &&
>> test_path_is_missing .git/NOTES_EDITMSG &&
>> test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
>> test "b2" = "$(git notes show)" &&
>> git show HEAD^ &&
>> test_must_fail git notes show HEAD^
>>
>> b2
>> not ok 14 - add w/no options on existing note morphs into edit
>> #
>> # MSG=b2 git notes add &&
>> # test_path_is_missing .git/NOTES_EDITMSG &&
>> # test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
>> # test "b2" = "$(git notes show)" &&
>> # git show HEAD^ &&
>> # test_must_fail git notes show HEAD^
>> #
>>
>> expecting success:
>> MSG=b1 git notes add -f &&
>> test_path_is_missing .git/NOTES_EDITMSG &&
>> test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
>> test "b1" = "$(git notes show)" &&
>> git show HEAD^ &&
>> test_must_fail git notes show HEAD^
>>
>> Overwriting existing notes for object 7a4ca6ee52a974a66cbaa78e33214535dff1d691
>> b1
>> not ok 15 - can overwrite existing note with "git notes add -f"
>> #
>> # MSG=b1 git notes add -f &&
>> # test_path_is_missing .git/NOTES_EDITMSG &&
>> # test "1" = "$(git ls-tree refs/notes/commits | wc -l)" &&
>> # test "b1" = "$(git notes show)" &&
>> # git show HEAD^ &&
>> # test_must_fail git notes show HEAD^
>> #
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit 7a4ca6ee52a974a66cbaa78e33214535dff1d691
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:14:13 2005 -0700
>>
>> ${indent}2nd
>>
>> Notes:
>> ${indent}b1
>> EOF
>> ! (git cat-file commit HEAD | grep b1) &&
>> git log -1 >output &&
>> test_cmp expect output
>>
>> ok 16 - show notes
>>
>> expecting success:
>> test_commit 3rd &&
>> MSG="b3${LF}c3c3c3c3${LF}d3d3d3" git notes add &&
>> cat >expect-multiline <<-EOF &&
>> commit d07d62e5208f22eb5695e7eb47667dc8b9860290
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:15:13 2005 -0700
>>
>> ${indent}3rd
>>
>> Notes:
>> ${indent}b3
>> ${indent}c3c3c3c3
>> ${indent}d3d3d3
>>
>> EOF
>> cat expect >>expect-multiline &&
>> git log -2 >output &&
>> test_cmp expect-multiline output
>>
>> [master d07d62e] 3rd
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 3rd.t
>> b3
>> c3c3c3c3
>> d3d3d3
>> ok 17 - show multi-line notes
>>
>> expecting success:
>> test_commit 4th &&
>> echo "xyzzy" >note5 &&
>> git notes add -F note5 &&
>> cat >expect-F <<-EOF &&
>> commit 0f7aa3ec6325aeb88b910453bb3eb37c49d75c11
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:16:13 2005 -0700
>>
>> ${indent}4th
>>
>> Notes:
>> ${indent}xyzzy
>>
>> EOF
>> cat expect-multiline >>expect-F &&
>> git log -3 >output &&
>> test_cmp expect-F output
>>
>> [master 0f7aa3e] 4th
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 4th.t
>> ok 18 - show -F notes
>>
>> expecting success:
>> echo "zyxxy" >note5 &&
>> test_must_fail git notes add -F note5 &&
>> git log -3 >output &&
>> test_cmp expect-F output
>>
>> error: Cannot add notes. Found existing notes for object
>> 0f7aa3ec6325aeb88b910453bb3eb37c49d75c11. Use '-f' to overwrite
>> existing notes
>> ok 19 - Re-adding -F notes without -f fails
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit 0f7aa3ec6325aeb88b910453bb3eb37c49d75c11
>> tree 05ac65288c4c4b3b709a020ae94b2ece2f2201ae
>> parent d07d62e5208f22eb5695e7eb47667dc8b9860290
>> author A U Thor <author@example.com> 1112912173 -0700
>> committer C O Mitter <committer@example.com> 1112912173 -0700
>>
>> ${indent}4th
>> EOF
>> git log -1 --pretty=raw >output &&
>> test_cmp expect output
>>
>> ok 20 - git log --pretty=raw does not show notes
>>
>> expecting success:
>> cat >>expect <<-EOF &&
>>
>> Notes:
>> ${indent}xyzzy
>> EOF
>> git log -1 --pretty=raw --show-notes >output &&
>> test_cmp expect output
>>
>> ok 21 - git log --show-notes
>>
>> expecting success:
>> git log -1 --no-notes >output &&
>> ! grep xyzzy output
>>
>> ok 22 - git log --no-notes
>>
>> expecting success:
>> git format-patch -1 --stdout >output &&
>> ! grep xyzzy output
>>
>> ok 23 - git format-patch does not show notes
>>
>> expecting success:
>> git format-patch --show-notes -1 --stdout >output &&
>> grep xyzzy output
>>
>>     xyzzy
>> ok 24 - git format-patch --show-notes does show notes
>>
>> expecting success:
>> git show $p >output &&
>> eval "$negate grep xyzzy output"
>>
>>     xyzzy
>> ok 25 - git show  does show notes
>>
>> expecting success:
>> git show $p >output &&
>> eval "$negate grep xyzzy output"
>>
>> ok 26 - git show --pretty does not show notes
>>
>> expecting success:
>> git show $p >output &&
>> eval "$negate grep xyzzy output"
>>
>> ok 27 - git show --pretty=raw does not show notes
>>
>> expecting success:
>> git show $p >output &&
>> eval "$negate grep xyzzy output"
>>
>> ok 28 - git show --pretty=short does not show notes
>>
>> expecting success:
>> git show $p >output &&
>> eval "$negate grep xyzzy output"
>>
>> ok 29 - git show --pretty=medium does not show notes
>>
>> expecting success:
>> git show $p >output &&
>> eval "$negate grep xyzzy output"
>>
>> ok 30 - git show --pretty=full does not show notes
>>
>> expecting success:
>> git show $p >output &&
>> eval "$negate grep xyzzy output"
>>
>> ok 31 - git show --pretty=fuller does not show notes
>>
>> expecting success:
>> git show $p >output &&
>> eval "$negate grep xyzzy output"
>>
>> ok 32 - git show --pretty=format:%s does not show notes
>>
>> expecting success:
>> git show $p >output &&
>> eval "$negate grep xyzzy output"
>>
>> ok 33 - git show --oneline does not show notes
>>
>> expecting success:
>> git notes --ref=alternate add -m alternate
>>
>> ok 34 - setup alternate notes ref
>>
>> expecting success:
>> git log -1 --notes >output &&
>> grep xyzzy output &&
>> ! grep alternate output
>>
>>     xyzzy
>> ok 35 - git log --notes shows default notes
>>
>> expecting success:
>> git log -1 --notes=alternate >output &&
>> ! grep xyzzy output &&
>> grep alternate output
>>
>> Notes (alternate):
>>     alternate
>> ok 36 - git log --notes=X shows only X
>>
>> expecting success:
>> git log -1 --notes --notes=alternate >output &&
>> grep xyzzy output &&
>> grep alternate output
>>
>>     xyzzy
>> Notes (alternate):
>>     alternate
>> ok 37 - git log --notes --notes=X shows both
>>
>> expecting success:
>> git log -1 --notes --notes=alternate \
>> --no-notes --notes=alternate \
>>>output &&
>> ! grep xyzzy output &&
>> grep alternate output
>>
>> Notes (alternate):
>>     alternate
>> ok 38 - git log --no-notes resets default state
>>
>> expecting success:
>> git log -1 --notes --notes=alternate \
>> --no-notes --notes \
>>>output &&
>> grep xyzzy output &&
>> ! grep alternate output
>>
>>     xyzzy
>> ok 39 - git log --no-notes resets ref list
>>
>> expecting success:
>> test_commit 5th &&
>> git notes add -m spam -m "foo${LF}bar${LF}baz" &&
>> cat >expect-m <<-EOF &&
>> commit 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:17:13 2005 -0700
>>
>> ${indent}5th
>>
>> Notes:
>> ${indent}spam
>> ${indent}
>> ${indent}foo
>> ${indent}bar
>> ${indent}baz
>>
>> EOF
>> cat expect-F >>expect-m &&
>> git log -4 >output &&
>> test_cmp expect-m output
>>
>> [master 7f9ad88] 5th
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 5th.t
>> ok 40 - show -m notes
>>
>> expecting success:
>> git notes add -f -F /dev/null &&
>> cat >expect-rm-F <<-EOF &&
>> commit 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:17:13 2005 -0700
>>
>> ${indent}5th
>>
>> EOF
>> cat expect-F >>expect-rm-F &&
>> git log -4 >output &&
>> test_cmp expect-rm-F output &&
>> test_must_fail git notes show
>>
>> Overwriting existing notes for object 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
>> Removing note for object 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
>> error: No note found for object 7f9ad8836c775acb134c0a055fc55fb4cd1ba361.
>> ok 41 - remove note with add -f -F /dev/null
>>
>> expecting success:
>> git notes add -m "" &&
>> git log -4 >output &&
>> test_cmp expect-rm-F output &&
>> test_must_fail git notes show
>>
>> Removing note for object 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
>> error: No note found for object 7f9ad8836c775acb134c0a055fc55fb4cd1ba361.
>> ok 42 - do not create empty note with -m ""
>>
>> expecting success:
>> cat >expect-combine_m_and_F <<-EOF &&
>> foo
>>
>> xyzzy
>>
>> bar
>>
>> zyxxy
>>
>> baz
>> EOF
>> echo "xyzzy" >note_a &&
>> echo "zyxxy" >note_b &&
>> git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" &&
>> git notes show >output &&
>> test_cmp expect-combine_m_and_F output
>>
>> ok 43 - create note with combination of -m and -F
>>
>> expecting success:
>> git notes remove HEAD^ &&
>> git notes remove &&
>> cat >expect-rm-remove <<-EOF &&
>> commit 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:17:13 2005 -0700
>>
>> ${indent}5th
>>
>> commit 0f7aa3ec6325aeb88b910453bb3eb37c49d75c11
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:16:13 2005 -0700
>>
>> ${indent}4th
>>
>> EOF
>> cat expect-multiline >>expect-rm-remove &&
>> git log -4 >output &&
>> test_cmp expect-rm-remove output &&
>> test_must_fail git notes show HEAD^
>>
>> Removing note for object HEAD^
>> Removing note for object HEAD
>> error: No note found for object 0f7aa3ec6325aeb88b910453bb3eb37c49d75c11.
>> ok 44 - remove note with "git notes remove"
>>
>> expecting success:
>> git rev-parse --verify refs/notes/commits >before_commit &&
>> test_must_fail git notes remove HEAD^ &&
>> git rev-parse --verify refs/notes/commits >after_commit &&
>> test_cmp before_commit after_commit
>>
>> Object HEAD^ has no note
>> ok 45 - removing non-existing note should not create new commit
>>
>> expecting success:
>> before=$(git rev-parse --verify refs/notes/commits) &&
>> test_when_finished "git update-ref refs/notes/commits $before" &&
>>
>> # We have only two -- add another and make sure it stays
>> git notes add -m "extra" &&
>> git notes list HEAD >after-removal-expect &&
>> git notes remove HEAD^^ HEAD^^^ &&
>> git notes list | sed -e "s/ .*//" >actual &&
>> test_cmp after-removal-expect actual
>>
>> Removing note for object HEAD^^
>> Removing note for object HEAD^^^
>> ok 46 - removing more than one
>>
>> expecting success:
>> before=$(git rev-parse --verify refs/notes/commits) &&
>> test_when_finished "git update-ref refs/notes/commits $before" &&
>> test_must_fail git notes remove HEAD^^ HEAD^^^ HEAD^ &&
>> after=$(git rev-parse --verify refs/notes/commits) &&
>> test "$before" = "$after"
>>
>> Removing note for object HEAD^^
>> Removing note for object HEAD^^^
>> Object HEAD^ has no note
>> ok 47 - removing is atomic
>>
>> expecting success:
>> before=$(git rev-parse --verify refs/notes/commits) &&
>> test_when_finished "git update-ref refs/notes/commits $before" &&
>>
>> # We have only two -- add another and make sure it stays
>> git notes add -m "extra" &&
>> git notes list HEAD >after-removal-expect &&
>> git notes remove --ignore-missing HEAD^^ HEAD^^^ HEAD^ &&
>> git notes list | sed -e "s/ .*//" >actual &&
>> test_cmp after-removal-expect actual
>>
>> Removing note for object HEAD^^
>> Removing note for object HEAD^^^
>> Object HEAD^ has no note
>> ok 48 - removing with --ignore-missing
>>
>> expecting success:
>> before=$(git rev-parse --verify refs/notes/commits) &&
>> test_when_finished "git update-ref refs/notes/commits $before" &&
>> test_must_fail git notes remove --ignore-missing HEAD^^ HEAD^^^
>> NO-SUCH-COMMIT &&
>> after=$(git rev-parse --verify refs/notes/commits) &&
>> test "$before" = "$after"
>>
>> Removing note for object HEAD^^
>> Removing note for object HEAD^^^
>> error: Failed to resolve 'NO-SUCH-COMMIT' as a valid ref.
>> ok 49 - removing with --ignore-missing but bogus ref
>>
>> expecting success:
>> before=$(git rev-parse --verify refs/notes/commits) &&
>> test_when_finished "git update-ref refs/notes/commits $before" &&
>>
>> # We have only two -- add another and make sure it stays
>> git notes add -m "extra" &&
>> git notes list HEAD >after-removal-expect &&
>> git rev-parse HEAD^^ HEAD^^^ >input &&
>> git notes remove --stdin <input &&
>> git notes list | sed -e "s/ .*//" >actual &&
>> test_cmp after-removal-expect actual
>>
>> Removing note for object d07d62e5208f22eb5695e7eb47667dc8b9860290
>> Removing note for object 7a4ca6ee52a974a66cbaa78e33214535dff1d691
>> ok 50 - remove reads from --stdin
>>
>> expecting success:
>> before=$(git rev-parse --verify refs/notes/commits) &&
>> test_when_finished "git update-ref refs/notes/commits $before" &&
>> git rev-parse HEAD^^ HEAD^^^ HEAD^ >input &&
>> test_must_fail git notes remove --stdin <input &&
>> after=$(git rev-parse --verify refs/notes/commits) &&
>> test "$before" = "$after"
>>
>> Removing note for object d07d62e5208f22eb5695e7eb47667dc8b9860290
>> Removing note for object 7a4ca6ee52a974a66cbaa78e33214535dff1d691
>> Object 0f7aa3ec6325aeb88b910453bb3eb37c49d75c11 has no note
>> ok 51 - remove --stdin is also atomic
>>
>> expecting success:
>> before=$(git rev-parse --verify refs/notes/commits) &&
>> test_when_finished "git update-ref refs/notes/commits $before" &&
>>
>> # We have only two -- add another and make sure it stays
>> git notes add -m "extra" &&
>> git notes list HEAD >after-removal-expect &&
>> git rev-parse HEAD^^ HEAD^^^ HEAD^ >input &&
>> git notes remove --ignore-missing --stdin <input &&
>> git notes list | sed -e "s/ .*//" >actual &&
>> test_cmp after-removal-expect actual
>>
>> Removing note for object d07d62e5208f22eb5695e7eb47667dc8b9860290
>> Removing note for object 7a4ca6ee52a974a66cbaa78e33214535dff1d691
>> Object 0f7aa3ec6325aeb88b910453bb3eb37c49d75c11 has no note
>> ok 52 - removing with --stdin --ignore-missing
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061
>> 7a4ca6ee52a974a66cbaa78e33214535dff1d691
>> c18dc024e14f08d18d14eea0d747ff692d66d6a3
>> d07d62e5208f22eb5695e7eb47667dc8b9860290
>> EOF
>> git notes list >output &&
>> test_cmp expect output
>>
>> ok 53 - list notes with "git notes list"
>>
>> expecting success:
>> git notes >output &&
>> test_cmp expect output
>>
>> ok 54 - list notes with "git notes"
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> c18dc024e14f08d18d14eea0d747ff692d66d6a3
>> EOF
>> git notes list HEAD^^ >output &&
>> test_cmp expect output
>>
>> ok 55 - list specific note with "git notes list <object>"
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> EOF
>> test_must_fail git notes list HEAD >output &&
>> test_cmp expect output
>>
>> error: No note found for object 7f9ad8836c775acb134c0a055fc55fb4cd1ba361.
>> ok 56 - listing non-existing notes fails
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> Initial set of notes
>>
>> More notes appended with git notes append
>> EOF
>> git notes add -m "Initial set of notes" &&
>> git notes append -m "More notes appended with git notes append" &&
>> git notes show >output &&
>> test_cmp expect output
>>
>> ok 57 - append to existing note with "git notes append"
>>
>> expecting success:
>> cat >expect_list <<-EOF &&
>> c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061
>> 7a4ca6ee52a974a66cbaa78e33214535dff1d691
>> 4b6ad22357cc8a1296720574b8d2fbc22fab0671
>> 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
>> c18dc024e14f08d18d14eea0d747ff692d66d6a3
>> d07d62e5208f22eb5695e7eb47667dc8b9860290
>> EOF
>> git notes list >output &&
>> test_cmp expect_list output
>>
>> ok 58 - "git notes list" does not expand to "git notes list HEAD"
>>
>> expecting success:
>> git notes append -m "" &&
>> git notes show >output &&
>> test_cmp expect output
>>
>> ok 59 - appending empty string does not change existing note
>>
>> expecting success:
>> git notes remove HEAD &&
>> test_must_fail git notes list HEAD &&
>> git notes append -m "Initial set of notes${LF}${LF}More notes appended
>> with git notes append" &&
>> git notes show >output &&
>> test_cmp expect output
>>
>> Removing note for object HEAD
>> error: No note found for object 7f9ad8836c775acb134c0a055fc55fb4cd1ba361.
>> ok 60 - git notes append == add when there is no existing note
>>
>> expecting success:
>> git notes remove HEAD &&
>> test_must_fail git notes list HEAD &&
>> git notes append -m "" &&
>> test_must_fail git notes list HEAD
>>
>> Removing note for object HEAD
>> error: No note found for object 7f9ad8836c775acb134c0a055fc55fb4cd1ba361.
>> Removing note for object 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
>> error: No note found for object 7f9ad8836c775acb134c0a055fc55fb4cd1ba361.
>> ok 61 - appending empty string to non-existing note does not create note
>>
>> expecting success:
>> test_commit 6th &&
>> GIT_NOTES_REF="refs/notes/other" git notes add -m "other note" &&
>> cat >expect-not-other <<-EOF &&
>> commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:18:13 2005 -0700
>>
>> ${indent}6th
>> EOF
>> cp expect-not-other expect-other &&
>> cat >>expect-other <<-EOF
>>
>> Notes (other):
>> ${indent}other note
>> EOF
>>
>> [master 2c12533] 6th
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 6th.t
>> ok 62 - create other note on a different notes ref (setup)
>>
>> expecting success:
>> git log -1 >output &&
>> test_cmp expect-not-other output
>>
>> ok 63 - Do not show note on other ref by default
>>
>> expecting success:
>> GIT_NOTES_REF="refs/notes/other" git log -1 >output &&
>> test_cmp expect-other output
>>
>> ok 64 - Do show note when ref is given in GIT_NOTES_REF
>>
>> expecting success:
>> test_config core.notesRef "refs/notes/other" &&
>> git log -1 >output &&
>> test_cmp expect-other output
>>
>> ok 65 - Do show note when ref is given in core.notesRef config
>>
>> expecting success:
>> test_config core.notesRef "refs/notes/other" &&
>> GIT_NOTES_REF="refs/notes/wrong" git log -1 >output &&
>> test_cmp expect-not-other output
>>
>> ok 66 - Do not show note when core.notesRef is overridden
>>
>> expecting success:
>> cat >expect-both <<-EOF &&
>> commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:18:13 2005 -0700
>>
>> ${indent}6th
>>
>> Notes:
>> ${indent}order test
>>
>> Notes (other):
>> ${indent}other note
>>
>> commit 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:17:13 2005 -0700
>>
>> ${indent}5th
>>
>> Notes:
>> ${indent}replacement for deleted note
>> EOF
>> GIT_NOTES_REF=refs/notes/commits git notes add \
>> -m"replacement for deleted note" HEAD^ &&
>> GIT_NOTES_REF=refs/notes/commits git notes add -m"order test" &&
>> test_unconfig core.notesRef &&
>> test_config notes.displayRef "refs/notes/*" &&
>> git log -2 >output &&
>> test_cmp expect-both output
>>
>> ok 67 - Show all notes when notes.displayRef=refs/notes/*
>>
>> expecting success:
>> test_config core.notesRef refs/notes/commits &&
>> test_config notes.displayRef refs/notes/other &&
>> git log -2 >output &&
>> test_cmp expect-both output
>>
>> ok 68 - core.notesRef is implicitly in notes.displayRef
>>
>> expecting success:
>> test_unconfig core.notesRef &&
>> test_config notes.displayRef refs/notes/commits &&
>> git config --add notes.displayRef refs/notes/other &&
>> git log -2 >output &&
>> test_cmp expect-both output
>>
>> ok 69 - notes.displayRef can be given more than once
>>
>> expecting success:
>> cat >expect-both-reversed <<-EOF &&
>> commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:18:13 2005 -0700
>>
>> ${indent}6th
>>
>> Notes (other):
>> ${indent}other note
>>
>> Notes:
>> ${indent}order test
>> EOF
>> test_config core.notesRef refs/notes/other &&
>> test_config notes.displayRef refs/notes/commits &&
>> git log -1 >output &&
>> test_cmp expect-both-reversed output
>>
>> ok 70 - notes.displayRef respects order
>>
>> expecting success:
>> GIT_NOTES_DISPLAY_REF=refs/notes/commits:refs/notes/other \
>> git log -2 >output &&
>> test_cmp expect-both output
>>
>> ok 71 - GIT_NOTES_DISPLAY_REF works
>>
>> expecting success:
>> cat >expect-none <<-EOF &&
>> commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:18:13 2005 -0700
>>
>> ${indent}6th
>>
>> commit 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:17:13 2005 -0700
>>
>> ${indent}5th
>> EOF
>> test_config notes.displayRef "refs/notes/*" &&
>> GIT_NOTES_REF= GIT_NOTES_DISPLAY_REF= git log -2 >output &&
>> test_cmp expect-none output
>>
>> ok 72 - GIT_NOTES_DISPLAY_REF overrides config
>>
>> expecting success:
>> GIT_NOTES_REF= GIT_NOTES_DISPLAY_REF= git log --show-notes=* -2 >output &&
>> test_cmp expect-both output
>>
>> ok 73 - --show-notes=* adds to GIT_NOTES_DISPLAY_REF
>>
>> expecting success:
>> cat >expect-commits <<EOF
>> commit 2c125331118caba0ff8238b7f4958ac6e93fe39c
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:18:13 2005 -0700
>>
>> ${indent}6th
>>
>> Notes:
>> ${indent}order test
>> EOF
>> git log --no-standard-notes --show-notes=commits -1 >output &&
>> test_cmp expect-commits output
>>
>> ok 74 - --no-standard-notes
>>
>> expecting success:
>> test_config notes.displayRef "refs/notes/*" &&
>> git log --no-standard-notes --show-notes=commits \
>> --standard-notes -2 >output &&
>> test_cmp expect-both output
>>
>> ok 75 - --standard-notes
>>
>> expecting success:
>> git log --show-notes=other --show-notes=commits \
>> --no-standard-notes -1 >output &&
>> test_cmp expect-both-reversed output
>>
>> ok 76 - --show-notes=ref accumulates
>>
>> expecting success:
>> test_config core.notesRef refs/notes/other &&
>> echo "Note on a tree" >expect &&
>> git notes add -m "Note on a tree" HEAD: &&
>> git notes show HEAD: >actual &&
>> test_cmp expect actual &&
>> echo "Note on a blob" >expect &&
>> filename=$(git ls-tree --name-only HEAD | head -n1) &&
>> git notes add -m "Note on a blob" HEAD:$filename &&
>> git notes show HEAD:$filename >actual &&
>> test_cmp expect actual &&
>> echo "Note on a tag" >expect &&
>> git tag -a -m "This is an annotated tag" foobar HEAD^ &&
>> git notes add -m "Note on a tag" foobar &&
>> git notes show foobar >actual &&
>> test_cmp expect actual
>>
>> ok 77 - Allow notes on non-commits (trees, blobs, tags)
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit fb01e0ca8c33b6cc0c6451dde747f97df567cb5c
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:19:13 2005 -0700
>>
>> ${indent}7th
>>
>> Notes:
>> ${indent}order test
>> EOF
>> test_commit 7th &&
>> git notes add -C $(git notes list HEAD^) &&
>> git log -1 >actual &&
>> test_cmp expect actual &&
>> test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
>>
>> [master fb01e0c] 7th
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 7th.t
>> ok 78 - create note from other note with "git notes add -C"
>>
>> expecting success:
>> test_commit 8th &&
>> test_must_fail git notes add -C deadbeef &&
>> test_must_fail git notes list HEAD
>>
>> [master 9a4c31c] 8th
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 8th.t
>> fatal: Failed to resolve 'deadbeef' as a valid ref.
>> error: No note found for object 9a4c31c7f722b5d517e92c64e932dd751e1413bf.
>> ok 79 - create note from non-existing note with "git notes add -C" fails
>>
>> expecting success:
>> commit=$(git rev-parse --verify HEAD) &&
>> tree=$(git rev-parse --verify HEAD:) &&
>> test_must_fail git notes add -C $commit &&
>> test_must_fail git notes add -C $tree &&
>> test_must_fail git notes list HEAD
>>
>> fatal: Cannot read note data from non-blob object
>> '9a4c31c7f722b5d517e92c64e932dd751e1413bf'.
>> fatal: Cannot read note data from non-blob object
>> '37f6454412e4ed89ae47782f956ed0fb573892f6'.
>> error: No note found for object 9a4c31c7f722b5d517e92c64e932dd751e1413bf.
>> ok 80 - create note from non-blob with "git notes add -C" fails
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit 9a4c31c7f722b5d517e92c64e932dd751e1413bf
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:20:13 2005 -0700
>>
>> ${indent}8th
>>
>> Notes:
>> ${indent}This is a blob object
>> EOF
>> blob=$(echo "This is a blob object" | git hash-object -w --stdin) &&
>> git notes add -C $blob &&
>> git log -1 >actual &&
>> test_cmp expect actual &&
>> test "$(git notes list HEAD)" = "$blob"
>>
>> ok 81 - create note from blob with "git notes add -C" reuses blob id
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit 2e0db4bc649e174d667a1cde19e725cf897a5bd2
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:21:13 2005 -0700
>>
>> ${indent}9th
>>
>> Notes:
>> ${indent}yet another note
>> EOF
>> test_commit 9th &&
>> MSG="yet another note" git notes add -c $(git notes list HEAD^^) &&
>> git log -1 >actual &&
>> test_cmp expect actual
>>
>> [master 2e0db4b] 9th
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 9th.t
>> yet another note
>> ok 82 - create note from other note with "git notes add -c"
>>
>> expecting success:
>> test_commit 10th &&
>> test_must_fail env MSG="yet another note" git notes add -c deadbeef &&
>> test_must_fail git notes list HEAD
>>
>> [master 7c3b87a] 10th
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 10th.t
>> fatal: Failed to resolve 'deadbeef' as a valid ref.
>> error: No note found for object 7c3b87ab368f81e11b1ea87b2ab99a71ccd25406.
>> ok 83 - create note from non-existing note with "git notes add -c" fails
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit 2e0db4bc649e174d667a1cde19e725cf897a5bd2
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:21:13 2005 -0700
>>
>> ${indent}9th
>>
>> Notes:
>> ${indent}yet another note
>> ${indent}
>> ${indent}yet another note
>> EOF
>> git notes append -C $(git notes list HEAD^) HEAD^ &&
>> git log -1 HEAD^ >actual &&
>> test_cmp expect actual
>>
>> ok 84 - append to note from other note with "git notes append -C"
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit 7c3b87ab368f81e11b1ea87b2ab99a71ccd25406
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:22:13 2005 -0700
>>
>> ${indent}10th
>>
>> Notes:
>> ${indent}other note
>> EOF
>> MSG="other note" git notes append -c $(git notes list HEAD^) &&
>> git log -1 >actual &&
>> test_cmp expect actual
>>
>> other note
>> ok 85 - create note from other note with "git notes append -c"
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit 7c3b87ab368f81e11b1ea87b2ab99a71ccd25406
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:22:13 2005 -0700
>>
>> ${indent}10th
>>
>> Notes:
>> ${indent}other note
>> ${indent}
>> ${indent}yet another note
>> EOF
>> MSG="yet another note" git notes append -c $(git notes list HEAD) &&
>> git log -1 >actual &&
>> test_cmp expect actual
>>
>> yet another note
>> ok 86 - append to note from other note with "git notes append -c"
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit a446fff8777efdc6eb8f4b7c8a5ff699484df0d5
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:23:13 2005 -0700
>>
>> ${indent}11th
>>
>> Notes:
>> ${indent}other note
>> ${indent}
>> ${indent}yet another note
>> EOF
>> test_commit 11th &&
>> git notes copy HEAD^ HEAD &&
>> git log -1 >actual &&
>> test_cmp expect actual &&
>> test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
>>
>> [master a446fff] 11th
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 11th.t
>> ok 87 - copy note with "git notes copy"
>>
>> expecting success:
>> test_must_fail git notes copy HEAD~2 HEAD &&
>> git log -1 >actual &&
>> test_cmp expect actual &&
>> test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
>>
>> error: Cannot copy notes. Found existing notes for object
>> a446fff8777efdc6eb8f4b7c8a5ff699484df0d5. Use '-f' to overwrite
>> existing notes
>> ok 88 - prevent overwrite with "git notes copy"
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit a446fff8777efdc6eb8f4b7c8a5ff699484df0d5
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:23:13 2005 -0700
>>
>> ${indent}11th
>>
>> Notes:
>> ${indent}yet another note
>> ${indent}
>> ${indent}yet another note
>> EOF
>> git notes copy -f HEAD~2 HEAD &&
>> git log -1 >actual &&
>> test_cmp expect actual &&
>> test "$(git notes list HEAD)" = "$(git notes list HEAD~2)"
>>
>> Overwriting existing notes for object a446fff8777efdc6eb8f4b7c8a5ff699484df0d5
>> ok 89 - allow overwrite with "git notes copy -f"
>>
>> expecting success:
>> test_commit 12th &&
>> test_commit 13th &&
>> test_must_fail git notes copy HEAD^ HEAD
>>
>> [master 65e263d] 12th
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 12th.t
>> [master e871aa6] 13th
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 13th.t
>> error: Missing notes on source object
>> 65e263ded02ae4e8839bc151095113737579dc12. Cannot copy.
>> ok 90 - cannot copy note from object without notes
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit e871aa61182b1d95d0a6fb75445d891722863b6b
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:25:13 2005 -0700
>>
>> ${indent}13th
>>
>> Notes:
>> ${indent}yet another note
>> ${indent}
>> ${indent}yet another note
>>
>> commit 65e263ded02ae4e8839bc151095113737579dc12
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:24:13 2005 -0700
>>
>> ${indent}12th
>>
>> Notes:
>> ${indent}other note
>> ${indent}
>> ${indent}yet another note
>> EOF
>> (echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
>> echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
>> git notes copy --stdin &&
>> git log -2 >output &&
>> test_cmp expect output &&
>> test "$(git notes list HEAD)" = "$(git notes list HEAD~2)" &&
>> test "$(git notes list HEAD^)" = "$(git notes list HEAD~3)"
>>
>> ok 91 - git notes copy --stdin
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:27:13 2005 -0700
>>
>> ${indent}15th
>>
>> commit 07c85d77059393ed0154b8c96906547a59dfcddd
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:26:13 2005 -0700
>>
>> ${indent}14th
>> EOF
>> test_commit 14th &&
>> test_commit 15th &&
>> (echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
>> echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
>> git notes copy --for-rewrite=foo &&
>> git log -2 >output &&
>> test_cmp expect output
>>
>> [master 07c85d7] 14th
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 14th.t
>> [master 4acf42e] 15th
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 15th.t
>> ok 92 - git notes copy --for-rewrite (unconfigured)
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:27:13 2005 -0700
>>
>> ${indent}15th
>>
>> Notes:
>> ${indent}yet another note
>> ${indent}
>> ${indent}yet another note
>>
>> commit 07c85d77059393ed0154b8c96906547a59dfcddd
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:26:13 2005 -0700
>>
>> ${indent}14th
>>
>> Notes:
>> ${indent}other note
>> ${indent}
>> ${indent}yet another note
>> EOF
>> test_config notes.rewriteMode overwrite &&
>> test_config notes.rewriteRef "refs/notes/*" &&
>> (echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
>> echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
>> git notes copy --for-rewrite=foo &&
>> git log -2 >output &&
>> test_cmp expect output
>>
>> ok 93 - git notes copy --for-rewrite (enabled)
>>
>> expecting success:
>> test_config notes.rewrite.bar false &&
>> echo $(git rev-parse HEAD~3) $(git rev-parse HEAD) |
>> git notes copy --for-rewrite=bar &&
>> git log -2 >output &&
>> test_cmp expect output
>>
>> ./test-lib.sh: line 536: echo: write error: Broken pipe
>> ok 94 - git notes copy --for-rewrite (disabled)
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:27:13 2005 -0700
>>
>> ${indent}15th
>>
>> Notes:
>> ${indent}a fresh note
>> EOF
>> git notes add -f -m"a fresh note" HEAD^ &&
>> test_config notes.rewriteMode overwrite &&
>> test_config notes.rewriteRef "refs/notes/*" &&
>> echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
>> git notes copy --for-rewrite=foo &&
>> git log -1 >output &&
>> test_cmp expect output
>>
>> Overwriting existing notes for object 07c85d77059393ed0154b8c96906547a59dfcddd
>> ok 95 - git notes copy --for-rewrite (overwrite)
>>
>> expecting success:
>> test_config notes.rewriteMode ignore &&
>> test_config notes.rewriteRef "refs/notes/*" &&
>> echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
>> git notes copy --for-rewrite=foo &&
>> git log -1 >output &&
>> test_cmp expect output
>>
>> ok 96 - git notes copy --for-rewrite (ignore)
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:27:13 2005 -0700
>>
>> ${indent}15th
>>
>> Notes:
>> ${indent}a fresh note
>> ${indent}
>> ${indent}another fresh note
>> EOF
>> git notes add -f -m"another fresh note" HEAD^ &&
>> test_config notes.rewriteMode concatenate &&
>> test_config notes.rewriteRef "refs/notes/*" &&
>> echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
>> git notes copy --for-rewrite=foo &&
>> git log -1 >output &&
>> test_cmp expect output
>>
>> Overwriting existing notes for object 07c85d77059393ed0154b8c96906547a59dfcddd
>> ok 97 - git notes copy --for-rewrite (append)
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:27:13 2005 -0700
>>
>> ${indent}15th
>>
>> Notes:
>> ${indent}a fresh note
>> ${indent}
>> ${indent}another fresh note
>> ${indent}
>> ${indent}append 1
>> ${indent}
>> ${indent}append 2
>> EOF
>> git notes add -f -m"append 1" HEAD^ &&
>> git notes add -f -m"append 2" HEAD^^ &&
>> test_config notes.rewriteMode concatenate &&
>> test_config notes.rewriteRef "refs/notes/*" &&
>> (echo $(git rev-parse HEAD^) $(git rev-parse HEAD);
>> echo $(git rev-parse HEAD^^) $(git rev-parse HEAD)) |
>> git notes copy --for-rewrite=foo &&
>> git log -1 >output &&
>> test_cmp expect output
>>
>> Overwriting existing notes for object 07c85d77059393ed0154b8c96906547a59dfcddd
>> Overwriting existing notes for object e871aa61182b1d95d0a6fb75445d891722863b6b
>> ok 98 - git notes copy --for-rewrite (append two to one)
>>
>> expecting success:
>> git notes remove HEAD^ &&
>> test_config notes.rewriteMode concatenate &&
>> test_config notes.rewriteRef "refs/notes/*" &&
>> echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
>> git notes copy --for-rewrite=foo &&
>> git log -1 >output &&
>> test_cmp expect output
>>
>> Removing note for object HEAD^
>> ok 99 - git notes copy --for-rewrite (append empty)
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:27:13 2005 -0700
>>
>> ${indent}15th
>>
>> Notes:
>> ${indent}replacement note 1
>> EOF
>> test_config notes.rewriteMode concatenate &&
>> test_config notes.rewriteRef "refs/notes/*" &&
>> git notes add -f -m"replacement note 1" HEAD^ &&
>> echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
>> GIT_NOTES_REWRITE_MODE=overwrite git notes copy --for-rewrite=foo &&
>> git log -1 >output &&
>> test_cmp expect output
>>
>> ok 100 - GIT_NOTES_REWRITE_MODE works
>>
>> expecting success:
>> cat >expect <<-EOF &&
>> commit 4acf42e847e7fffbbf89ee365c20ac7caf40de89
>> Author: A U Thor <author@example.com>
>> Date:   Thu Apr 7 15:27:13 2005 -0700
>>
>> ${indent}15th
>>
>> Notes:
>> ${indent}replacement note 2
>> EOF
>> git notes add -f -m"replacement note 2" HEAD^ &&
>> test_config notes.rewriteMode overwrite &&
>> test_unconfig notes.rewriteRef &&
>> echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
>> GIT_NOTES_REWRITE_REF=refs/notes/commits:refs/notes/other \
>> git notes copy --for-rewrite=foo &&
>> git log -1 >output &&
>> test_cmp expect output
>>
>> Overwriting existing notes for object 07c85d77059393ed0154b8c96906547a59dfcddd
>> ok 101 - GIT_NOTES_REWRITE_REF works
>>
>> expecting success:
>> git notes add -f -m"replacement note 3" HEAD^ &&
>> test_config notes.rewriteMode overwrite &&
>> test_config notes.rewriteRef refs/notes/other &&
>> echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
>> GIT_NOTES_REWRITE_REF= git notes copy --for-rewrite=foo &&
>> git log -1 >output &&
>> test_cmp expect output
>>
>> Overwriting existing notes for object 07c85d77059393ed0154b8c96906547a59dfcddd
>> ./test-lib.sh: line 538: echo: write error: Broken pipe
>> ok 102 - GIT_NOTES_REWRITE_REF overrides config
>>
>> expecting success:
>> test_must_fail git notes copy &&
>> test_must_fail git notes copy one two three
>>
>> error: too few parameters
>> usage: git notes copy [<options>] <from-object> <to-object>
>>    or: git notes copy --stdin [<from-object> <to-object>]...
>>
>>     -f, --force           replace existing notes
>>     --stdin               read objects from stdin
>>     --for-rewrite <command>
>>                           load rewriting config for <command> (implies --stdin)
>>
>> error: too many parameters
>> usage: git notes copy [<options>] <from-object> <to-object>
>>    or: git notes copy --stdin [<from-object> <to-object>]...
>>
>>     -f, --force           replace existing notes
>>     --stdin               read objects from stdin
>>     --for-rewrite <command>
>>                           load rewriting config for <command> (implies --stdin)
>>
>> ok 103 - git notes copy diagnoses too many or too few parameters
>>
>> expecting success:
>> test_unconfig core.notesRef &&
>> sane_unset GIT_NOTES_REF &&
>> test "$(git notes get-ref)" = "refs/notes/commits"
>>
>> ok 104 - git notes get-ref (no overrides)
>>
>> expecting success:
>> test_config core.notesRef refs/notes/foo &&
>> test "$(git notes get-ref)" = "refs/notes/foo"
>>
>> ok 105 - git notes get-ref (core.notesRef)
>>
>> expecting success:
>> test "$(GIT_NOTES_REF=refs/notes/bar git notes get-ref)" = "refs/notes/bar"
>>
>> ok 106 - git notes get-ref (GIT_NOTES_REF)
>>
>> expecting success:
>> test "$(GIT_NOTES_REF=refs/notes/bar git notes --ref=baz get-ref)" =
>> "refs/notes/baz"
>>
>> ok 107 - git notes get-ref (--ref)
>>
>> expecting success:
>> test_unconfig core.notesRef &&
>> test_commit 16th &&
>> empty_blob=$(git hash-object -w /dev/null) &&
>> echo "$empty_blob" >expect_empty
>>
>> [master 21d0abc] 16th
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 16th.t
>> ok 108 - setup testing of empty notes
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes add &&
>> test_must_fail git notes list HEAD
>>
>> Object HEAD has no note
>>
>> Removing note for object 21d0abcd10f591529d5148ae8bc7703fc1f73398
>> error: No note found for object 21d0abcd10f591529d5148ae8bc7703fc1f73398.
>> ok 109 - 'git notes add' removes empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes add --allow-empty &&
>> git notes list HEAD >actual &&
>> test_cmp expect_empty actual
>>
>> Object HEAD has no note
>>
>> ok 110 - 'git notes add --allow-empty' stores empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes add -F /dev/null &&
>> test_must_fail git notes list HEAD
>>
>> Removing note for object HEAD
>> Removing note for object 21d0abcd10f591529d5148ae8bc7703fc1f73398
>> error: No note found for object 21d0abcd10f591529d5148ae8bc7703fc1f73398.
>> ok 111 - 'git notes add -F /dev/null' removes empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes add -F /dev/null --allow-empty &&
>> git notes list HEAD >actual &&
>> test_cmp expect_empty actual
>>
>> Object HEAD has no note
>> ok 112 - 'git notes add -F /dev/null --allow-empty' stores empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes add -m "" &&
>> test_must_fail git notes list HEAD
>>
>> Removing note for object HEAD
>> Removing note for object 21d0abcd10f591529d5148ae8bc7703fc1f73398
>> error: No note found for object 21d0abcd10f591529d5148ae8bc7703fc1f73398.
>> ok 113 - 'git notes add -m ""' removes empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes add -m "" --allow-empty &&
>> git notes list HEAD >actual &&
>> test_cmp expect_empty actual
>>
>> Object HEAD has no note
>> ok 114 - 'git notes add -m "" --allow-empty' stores empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes add -c "$empty_blob" &&
>> test_must_fail git notes list HEAD
>>
>> Removing note for object HEAD
>>
>> Removing note for object 21d0abcd10f591529d5148ae8bc7703fc1f73398
>> error: No note found for object 21d0abcd10f591529d5148ae8bc7703fc1f73398.
>> ok 115 - 'git notes add -c "$empty_blob"' removes empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes add -c "$empty_blob" --allow-empty &&
>> git notes list HEAD >actual &&
>> test_cmp expect_empty actual
>>
>> Object HEAD has no note
>>
>> ok 116 - 'git notes add -c "$empty_blob" --allow-empty' stores empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes add -C "$empty_blob" &&
>> test_must_fail git notes list HEAD
>>
>> Removing note for object HEAD
>> Removing note for object 21d0abcd10f591529d5148ae8bc7703fc1f73398
>> error: No note found for object 21d0abcd10f591529d5148ae8bc7703fc1f73398.
>> ok 117 - 'git notes add -C "$empty_blob"' removes empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes add -C "$empty_blob" --allow-empty &&
>> git notes list HEAD >actual &&
>> test_cmp expect_empty actual
>>
>> Object HEAD has no note
>> ok 118 - 'git notes add -C "$empty_blob" --allow-empty' stores empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes append &&
>> test_must_fail git notes list HEAD
>>
>> Removing note for object HEAD
>>
>> Removing note for object 21d0abcd10f591529d5148ae8bc7703fc1f73398
>> error: No note found for object 21d0abcd10f591529d5148ae8bc7703fc1f73398.
>> ok 119 - 'git notes append' removes empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes append --allow-empty &&
>> git notes list HEAD >actual &&
>> test_cmp expect_empty actual
>>
>> Object HEAD has no note
>>
>> ok 120 - 'git notes append --allow-empty' stores empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes append -F /dev/null &&
>> test_must_fail git notes list HEAD
>>
>> Removing note for object HEAD
>> Removing note for object 21d0abcd10f591529d5148ae8bc7703fc1f73398
>> error: No note found for object 21d0abcd10f591529d5148ae8bc7703fc1f73398.
>> ok 121 - 'git notes append -F /dev/null' removes empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes append -F /dev/null --allow-empty &&
>> git notes list HEAD >actual &&
>> test_cmp expect_empty actual
>>
>> Object HEAD has no note
>> ok 122 - 'git notes append -F /dev/null --allow-empty' stores empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes append -m "" &&
>> test_must_fail git notes list HEAD
>>
>> Removing note for object HEAD
>> Removing note for object 21d0abcd10f591529d5148ae8bc7703fc1f73398
>> error: No note found for object 21d0abcd10f591529d5148ae8bc7703fc1f73398.
>> ok 123 - 'git notes append -m ""' removes empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes append -m "" --allow-empty &&
>> git notes list HEAD >actual &&
>> test_cmp expect_empty actual
>>
>> Object HEAD has no note
>> ok 124 - 'git notes append -m "" --allow-empty' stores empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes append -c "$empty_blob" &&
>> test_must_fail git notes list HEAD
>>
>> Removing note for object HEAD
>>
>> Removing note for object 21d0abcd10f591529d5148ae8bc7703fc1f73398
>> error: No note found for object 21d0abcd10f591529d5148ae8bc7703fc1f73398.
>> ok 125 - 'git notes append -c "$empty_blob"' removes empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes append -c "$empty_blob" --allow-empty &&
>> git notes list HEAD >actual &&
>> test_cmp expect_empty actual
>>
>> Object HEAD has no note
>>
>> ok 126 - 'git notes append -c "$empty_blob" --allow-empty' stores empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes append -C "$empty_blob" &&
>> test_must_fail git notes list HEAD
>>
>> Removing note for object HEAD
>> Removing note for object 21d0abcd10f591529d5148ae8bc7703fc1f73398
>> error: No note found for object 21d0abcd10f591529d5148ae8bc7703fc1f73398.
>> ok 127 - 'git notes append -C "$empty_blob"' removes empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes append -C "$empty_blob" --allow-empty &&
>> git notes list HEAD >actual &&
>> test_cmp expect_empty actual
>>
>> Object HEAD has no note
>> ok 128 - 'git notes append -C "$empty_blob" --allow-empty' stores empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes edit &&
>> test_must_fail git notes list HEAD
>>
>> Removing note for object HEAD
>>
>> Removing note for object 21d0abcd10f591529d5148ae8bc7703fc1f73398
>> error: No note found for object 21d0abcd10f591529d5148ae8bc7703fc1f73398.
>> ok 129 - 'git notes edit' removes empty note
>>
>> expecting success:
>> test_might_fail git notes remove HEAD &&
>> MSG= git notes edit --allow-empty &&
>> git notes list HEAD >actual &&
>> test_cmp expect_empty actual
>>
>> Object HEAD has no note
>>
>> ok 130 - 'git notes edit --allow-empty' stores empty note
>>
>> expecting success:
>> test_commit 17th &&
>> git log -1 >expect &&
>> cat >>expect <<-EOF &&
>>
>> Notes:
>> EOF
>> git notes add -C "$empty_blob" --allow-empty &&
>> git log -1 >actual &&
>> test_cmp expect actual
>>
>> [master 27a79f3] 17th
>>  Author: A U Thor <author@example.com>
>>  1 file changed, 1 insertion(+)
>>  create mode 100644 17th.t
>> ok 131 - empty notes are displayed by git log
>>
>> # failed 6 among 131 test(s)
>> 1..131
