Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D907FC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 00:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9ACB60F41
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 00:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhG1AOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 20:14:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52506 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhG1AOr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 20:14:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3CF8F1430CB;
        Tue, 27 Jul 2021 20:14:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dHfBWdqd+tGgGfXwCRJ2pR/iOF88CfiNPVigaW
        k33tE=; b=oUVZoquxA8LrURTFL8oQQkKIsoGgMfdu3O87OAbkJySNimrcdtYcF/
        8GBjYSEWn4ktqp1PBwHrfhM3++RMuMnvREDIAhscPcHrcYLPTiyQuU6cPdRSvFc2
        RDqemHAfT5h/zbFTxODSyCFE9YsUDUfU8VO+099HLFEHT80095WW4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 357ED1430CA;
        Tue, 27 Jul 2021 20:14:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 73ECA1430C9;
        Tue, 27 Jul 2021 20:14:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 4/5] Use a better name for the function interpolating
 paths
References: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
        <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
        <19fd9c3c803a300b586c76736301a7379c4c6226.1627164413.git.gitgitgadget@gmail.com>
        <xmqqh7gghgtd.fsf@gitster.g>
        <99332fdf-24af-8938-2f55-b6e25ca12aad@gigacodes.de>
        <xmqqfsvzcqmo.fsf@gitster.g>
Date:   Tue, 27 Jul 2021 17:14:42 -0700
In-Reply-To: <xmqqfsvzcqmo.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        27 Jul 2021 15:56:47 -0700")
Message-ID: <xmqq8s1rcn0t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF96F9EE-EF38-11EB-BAE0-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Fabian Stelzer <fs@gigacodes.de> writes:
>
>>> I think Fabian's "ssh signing" is not as ready as this topic, and it
>>> can afford to wait by rebasing on top of this topic.  By the time
>>> "ssh signing" gets into testable shape (right now, it does not pass
>>> tests when merged to 'seen'), hopefully the "expand install-prefix"
>>> topic may already be in 'next' if not in 'master'.
>> I think the test problem is not due to my patch.
>
> I've been seeing these test failers locally, every time
> fs/ssh-signing topic is merged to 'seen' (without the reftable
> thing).
>
> Test Summary Report
> -------------------
> t5534-push-signed.sh                             (Wstat: 256 Tests: 13 Failed: 2)
>   Failed tests:  8, 12
>   Non-zero exit status: 1
> t7528-signed-commit-ssh.sh                       (Wstat: 256 Tests: 23 Failed: 2)
>   Failed tests:  13, 17
>   Non-zero exit status: 1
>
> When reftable thing is merged, either compilation fails or t0031
> fails, and I suspect that these are not due to the ssh signing
> topic.

Interesting.  It seems that the failure has some correlation with
the use of --root=<trash directory> option.

    $ sh t5534-push-signed.sh -i
    ok 1 - setup
    ok 2 - unsigned push does not send push certificate
    ok 3 - talking with a receiver without push certificate support
    ok 4 - push --signed fails with a receiver without push certificate
    support
    ok 5 - push --signed=1 is accepted
    ok 6 - no certificate for a signed push with no update
    ok 7 - signed push sends push certificate
    ok 8 - ssh signed push sends push certificate
    ok 9 - inconsistent push options in signed push not allowed
    ok 10 - fail without key and heed user.signingkey
    ok 11 - fail without key and heed user.signingkey x509
    ok 12 - fail without key and heed user.signingkey ssh
    ok 13 - failed atomic push does not execute GPG
    # passed all 13 test(s)
    1..13

passes just fine, but

    $ TESTPEN=/dev/shm/testpen.$$
    $ rm -fr "$TESTPEN" && mkdir "$TESTPEN"
    $ sh t5534-push-signed.sh --root=$TESTPEN -i -v

dies like this:

Initialized empty Git repository in /dev/shm/testpen.9441/trash directory.t5534-push-signed/.git/
expecting success of 5534.1 'setup': 
	# main, ff and noff branches pointing at the same commit
	test_tick &&
	git commit --allow-empty -m initial &&

	git checkout -b noop &&
	git checkout -b ff &&
	git checkout -b noff &&

	# noop stays the same, ff advances, noff rewrites
	test_tick &&
	git commit --allow-empty --amend -m rewritten &&
	git checkout ff &&

	test_tick &&
	git commit --allow-empty -m second

[main (root-commit) 66fe8b3] initial
 Author: A U Thor <author@example.com>
Switched to a new branch 'noop'
Switched to a new branch 'ff'
Switched to a new branch 'noff'
[noff 6391b7f] rewritten
 Author: A U Thor <author@example.com>
 Date: Thu Apr 7 15:13:13 2005 -0700
Switched to branch 'ff'
[ff 566fbd3] second
 Author: A U Thor <author@example.com>
ok 1 - setup

expecting success of 5534.2 'unsigned push does not send push certificate': 
	prepare_dst &&
	mkdir -p dst/.git/hooks &&
	write_script dst/.git/hooks/post-receive <<-\EOF &&
	# discard the update list
	cat >/dev/null
	# record the push certificate
	if test -n "${GIT_PUSH_CERT-}"
	then
		git cat-file blob $GIT_PUSH_CERT >../push-cert
	fi
	EOF

	git push dst noop ff +noff &&
	! test -f dst/push-cert

Initialized empty Git repository in /dev/shm/testpen.9441/trash directory.t5534-push-signed/dst/.git/
To dst
 * [new branch]      main -> noop
 * [new branch]      main -> ff
 * [new branch]      main -> noff
To dst
   66fe8b3..566fbd3  ff -> ff
 + 66fe8b3...6391b7f noff -> noff (forced update)
ok 2 - unsigned push does not send push certificate

expecting success of 5534.3 'talking with a receiver without push certificate support': 
	prepare_dst &&
	mkdir -p dst/.git/hooks &&
	write_script dst/.git/hooks/post-receive <<-\EOF &&
	# discard the update list
	cat >/dev/null
	# record the push certificate
	if test -n "${GIT_PUSH_CERT-}"
	then
		git cat-file blob $GIT_PUSH_CERT >../push-cert
	fi
	EOF

	git push dst noop ff +noff &&
	! test -f dst/push-cert

Initialized empty Git repository in /dev/shm/testpen.9441/trash directory.t5534-push-signed/dst/.git/
To dst
 * [new branch]      main -> noop
 * [new branch]      main -> ff
 * [new branch]      main -> noff
To dst
   66fe8b3..566fbd3  ff -> ff
 + 66fe8b3...6391b7f noff -> noff (forced update)
ok 3 - talking with a receiver without push certificate support

expecting success of 5534.4 'push --signed fails with a receiver without push certificate support': 
	prepare_dst &&
	mkdir -p dst/.git/hooks &&
	test_must_fail git push --signed dst noop ff +noff 2>err &&
	test_i18ngrep "the receiving end does not support" err

Initialized empty Git repository in /dev/shm/testpen.9441/trash directory.t5534-push-signed/dst/.git/
To dst
 * [new branch]      main -> noop
 * [new branch]      main -> ff
 * [new branch]      main -> noff
fatal: the receiving end does not support --signed push
ok 4 - push --signed fails with a receiver without push certificate support

expecting success of 5534.5 'push --signed=1 is accepted': 
	prepare_dst &&
	mkdir -p dst/.git/hooks &&
	test_must_fail git push --signed=1 dst noop ff +noff 2>err &&
	test_i18ngrep "the receiving end does not support" err

Initialized empty Git repository in /dev/shm/testpen.9441/trash directory.t5534-push-signed/dst/.git/
To dst
 * [new branch]      main -> noop
 * [new branch]      main -> ff
 * [new branch]      main -> noff
fatal: the receiving end does not support --signed push
ok 5 - push --signed=1 is accepted

checking prerequisite: GPG

mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-GPG" &&
(
	cd "$TRASH_DIRECTORY/prereq-test-dir-GPG" &&
	gpg_version=$(gpg --version 2>&1)
	test $? != 127 || exit 1

	# As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
	# the gpg version 1.0.6 did not parse trust packets correctly, so for
	# that version, creation of signed tags using the generated key fails.
	case "$gpg_version" in
	"gpg (GnuPG) 1.0.6"*)
		say "Your version of gpg (1.0.6) is too buggy for testing"
		exit 1
		;;
	*)
		# Available key info:
		# * Type DSA and Elgamal, size 2048 bits, no expiration date,
		#   name and email: C O Mitter <committer@example.com>
		# * Type RSA, size 2048 bits, no expiration date,
		#   name and email: Eris Discordia <discord@example.net>
		# No password given, to enable non-interactive operation.
		# To generate new key:
		#	gpg --homedir /tmp/gpghome --gen-key
		# To write armored exported key to keyring:
		#	gpg --homedir /tmp/gpghome --export-secret-keys \
		#		--armor 0xDEADBEEF >> lib-gpg/keyring.gpg
		#	gpg --homedir /tmp/gpghome --export \
		#		--armor 0xDEADBEEF >> lib-gpg/keyring.gpg
		# To export ownertrust:
		#	gpg --homedir /tmp/gpghome --export-ownertrust \
		#		> lib-gpg/ownertrust
		mkdir "$GNUPGHOME" &&
		chmod 0700 "$GNUPGHOME" &&
		(gpgconf --kill gpg-agent || : ) &&
		gpg --homedir "${GNUPGHOME}" --import \
			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null \
			--sign -u committer@example.com
		;;
	esac

)
gpg: keybox '/dev/shm/testpen.9441/trash directory.t5534-push-signed/gpghome/pubring.kbx' created
gpg: /dev/shm/testpen.9441/trash directory.t5534-push-signed/gpghome/trustdb.gpg: trustdb created
gpg: key 13B6F51ECDDE430D: public key "C O Mitter <committer@example.com>" imported
gpg: key 13B6F51ECDDE430D: secret key imported
gpg: key 61092E85B7227189: public key "Eris Discordia <discord@example.net>" imported
gpg: key 61092E85B7227189: secret key imported
gpg: key 13B6F51ECDDE430D: "C O Mitter <committer@example.com>" not changed
gpg: key 61092E85B7227189: "Eris Discordia <discord@example.net>" not changed
gpg: Total number processed: 4
gpg:               imported: 2
gpg:              unchanged: 2
gpg:       secret keys read: 2
gpg:   secret keys imported: 2
gpg: inserting ownertrust of 6
gpg: inserting ownertrust of 3
prerequisite GPG ok
expecting success of 5534.6 'no certificate for a signed push with no update': 
	prepare_dst &&
	mkdir -p dst/.git/hooks &&
	write_script dst/.git/hooks/post-receive <<-\EOF &&
	if test -n "${GIT_PUSH_CERT-}"
	then
		git cat-file blob $GIT_PUSH_CERT >../push-cert
	fi
	EOF
	git push dst noop &&
	! test -f dst/push-cert

Initialized empty Git repository in /dev/shm/testpen.9441/trash directory.t5534-push-signed/dst/.git/
To dst
 * [new branch]      main -> noop
 * [new branch]      main -> ff
 * [new branch]      main -> noff
Everything up-to-date
ok 6 - no certificate for a signed push with no update

expecting success of 5534.7 'signed push sends push certificate': 
	prepare_dst &&
	mkdir -p dst/.git/hooks &&
	git -C dst config receive.certnonceseed sekrit &&
	write_script dst/.git/hooks/post-receive <<-\EOF &&
	# discard the update list
	cat >/dev/null
	# record the push certificate
	if test -n "${GIT_PUSH_CERT-}"
	then
		git cat-file blob $GIT_PUSH_CERT >../push-cert
	fi &&

	cat >../push-cert-status <<E_O_F
	SIGNER=${GIT_PUSH_CERT_SIGNER-nobody}
	KEY=${GIT_PUSH_CERT_KEY-nokey}
	STATUS=${GIT_PUSH_CERT_STATUS-nostatus}
	NONCE_STATUS=${GIT_PUSH_CERT_NONCE_STATUS-nononcestatus}
	NONCE=${GIT_PUSH_CERT_NONCE-nononce}
	E_O_F

	EOF

	git push --signed dst noop ff +noff &&

	(
		cat <<-\EOF &&
		SIGNER=C O Mitter <committer@example.com>
		KEY=13B6F51ECDDE430D
		STATUS=G
		NONCE_STATUS=OK
		EOF
		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
	) >expect &&

	noop=$(git rev-parse noop) &&
	ff=$(git rev-parse ff) &&
	noff=$(git rev-parse noff) &&
	grep "$noop $ff refs/heads/ff" dst/push-cert &&
	grep "$noop $noff refs/heads/noff" dst/push-cert &&
	test_cmp expect dst/push-cert-status

Initialized empty Git repository in /dev/shm/testpen.9441/trash directory.t5534-push-signed/dst/.git/
To dst
 * [new branch]      main -> noop
 * [new branch]      main -> ff
 * [new branch]      main -> noff
To dst
   66fe8b3..566fbd3  ff -> ff
 + 66fe8b3...6391b7f noff -> noff (forced update)
66fe8b3f2df5c2a6e67944af865f3a0893093d69 566fbd34a75c18947f0bcd052512caf55e7144ba refs/heads/ff
66fe8b3f2df5c2a6e67944af865f3a0893093d69 6391b7f36bc1393eab3cad0aaf8c08cdacbe78fa refs/heads/noff
ok 7 - signed push sends push certificate

checking prerequisite: GPGSSH

mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-GPGSSH" &&
(
	cd "$TRASH_DIRECTORY/prereq-test-dir-GPGSSH" &&
	ssh_version=$(ssh-keygen -Y find-principals -n "git" 2>&1)
	test $? != 127 || exit 1
	echo $ssh_version | grep -q "find-principals:missing signature file"
	test $? = 0 || exit 1;
	mkdir -p "${GNUPGHOME}" &&
	chmod 0700 "${GNUPGHOME}" &&
	ssh-keygen -t ed25519 -N "" -f "${GNUPGHOME}/ed25519_ssh_signing_key" >/dev/null &&
	ssh-keygen -t rsa -b 2048 -N "" -f "${GNUPGHOME}/rsa_2048_ssh_signing_key" >/dev/null &&
	ssh-keygen -t ed25519 -N "super_secret" -f "${GNUPGHOME}/protected_ssh_signing_key" >/dev/null &&
	find "${GNUPGHOME}" -name *ssh_signing_key.pub -exec cat {} \; | awk "{print \"\\\"principal with number \" NR \"\\\" \" \$0}" > "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
	cat "${GNUPGHOME}/ssh.all_valid.allowedSignersFile" &&
	ssh-keygen -t ed25519 -N "" -f "${GNUPGHOME}/untrusted_ssh_signing_key" >/dev/null

)
"principal with number 1" ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK+hDFZT7sYN3M+1ciMGLTM6pu/xmJrNDTK/vN+QIVnq jch@gitster.c.googlers.com
"principal with number 2" ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWLnqVpDYNstR7jCPKr1FaWzxt7NNw/kEV61GgKThW9S54/p/0WN+SCtUI0j7dCv/NkNhy87WNhohC9rCvZowPf/HRflHZ28vVk5d0DERCmlLBHnTq65Buyzj2R5xMtyVOBBMd+Io6tXk6GfJ6Dvq9l1wIJLv3OodOLBym3idV+8C+GOw9teTOlQWwkZD2hAt0n1Dy5WtaeGm3O2aUwRyg7KuxxmsgadBJ13a9thMYpwkS1McnwB+7oS81VXeeF0WcKAa2tGvxlg8NdBZuvvLJkl5vcISnpjt0NIuhqHzMlBIprpKujkZ5ze18YHXA52w6Y+9hG40n819EKjQfBVtD jch@gitster.c.googlers.com
"principal with number 3" ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAgtFx51cu1d0gzZOjIdw4M9oBYgV+tX6Bsm2L+riv/Z jch@gitster.c.googlers.com
prerequisite GPGSSH ok
expecting success of 5534.8 'ssh signed push sends push certificate': 
	prepare_dst &&
	mkdir -p dst/.git/hooks &&
	git -C dst config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
	git -C dst config receive.certnonceseed sekrit &&
	write_script dst/.git/hooks/post-receive <<-\EOF &&
	# discard the update list
	cat >/dev/null
	# record the push certificate
	if test -n "${GIT_PUSH_CERT-}"
	then
		git cat-file blob $GIT_PUSH_CERT >../push-cert
	fi &&

	cat >../push-cert-status <<E_O_F
	SIGNER=${GIT_PUSH_CERT_SIGNER-nobody}
	KEY=${GIT_PUSH_CERT_KEY-nokey}
	STATUS=${GIT_PUSH_CERT_STATUS-nostatus}
	NONCE_STATUS=${GIT_PUSH_CERT_NONCE_STATUS-nononcestatus}
	NONCE=${GIT_PUSH_CERT_NONCE-nononce}
	E_O_F

	EOF

	test_config gpg.format ssh &&
	test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
	FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_PRIMARY}" | awk "{print \$2;}") &&
	git push --signed dst noop ff +noff &&

	(
		cat <<-\EOF &&
		SIGNER=principal with number 1
		KEY=FINGERPRINT
		STATUS=G
		NONCE_STATUS=OK
		EOF
		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
	) | sed -e "s|FINGERPRINT|$FINGERPRINT|" >expect &&

	noop=$(git rev-parse noop) &&
	ff=$(git rev-parse ff) &&
	noff=$(git rev-parse noff) &&
	grep "$noop $ff refs/heads/ff" dst/push-cert &&
	grep "$noop $noff refs/heads/noff" dst/push-cert &&
	test_cmp expect dst/push-cert-status

Initialized empty Git repository in /dev/shm/testpen.9441/trash directory.t5534-push-signed/dst/.git/
To dst
 * [new branch]      main -> noop
 * [new branch]      main -> ff
 * [new branch]      main -> noff
To dst
   66fe8b3..566fbd3  ff -> ff
 + 66fe8b3...6391b7f noff -> noff (forced update)
66fe8b3f2df5c2a6e67944af865f3a0893093d69 566fbd34a75c18947f0bcd052512caf55e7144ba refs/heads/ff
66fe8b3f2df5c2a6e67944af865f3a0893093d69 6391b7f36bc1393eab3cad0aaf8c08cdacbe78fa refs/heads/noff
--- expect	2021-07-28 00:11:20.863019887 +0000
+++ dst/push-cert-status	2021-07-28 00:11:20.855019156 +0000
@@ -1,4 +1,4 @@
-SIGNER=principal with number 1
+SIGNER=principal with number 3
 KEY=SHA256:Szd5rzYOrMBJFTR+gnRUu60YRVqg98UvpcSvmAm89rE
 STATUS=G
 NONCE_STATUS=OK
not ok 8 - ssh signed push sends push certificate
#	
#		prepare_dst &&
#		mkdir -p dst/.git/hooks &&
#		git -C dst config gpg.ssh.allowedSignersFile "${SIGNING_ALLOWED_SIGNERS}" &&
#		git -C dst config receive.certnonceseed sekrit &&
#		write_script dst/.git/hooks/post-receive <<-\EOF &&
#		# discard the update list
#		cat >/dev/null
#		# record the push certificate
#		if test -n "${GIT_PUSH_CERT-}"
#		then
#			git cat-file blob $GIT_PUSH_CERT >../push-cert
#		fi &&
#	
#		cat >../push-cert-status <<E_O_F
#		SIGNER=${GIT_PUSH_CERT_SIGNER-nobody}
#		KEY=${GIT_PUSH_CERT_KEY-nokey}
#		STATUS=${GIT_PUSH_CERT_STATUS-nostatus}
#		NONCE_STATUS=${GIT_PUSH_CERT_NONCE_STATUS-nononcestatus}
#		NONCE=${GIT_PUSH_CERT_NONCE-nononce}
#		E_O_F
#	
#		EOF
#	
#		test_config gpg.format ssh &&
#		test_config user.signingkey "${SIGNING_KEY_PRIMARY}" &&
#		FINGERPRINT=$(ssh-keygen -lf "${SIGNING_KEY_PRIMARY}" | awk "{print \$2;}") &&
#		git push --signed dst noop ff +noff &&
#	
#		(
#			cat <<-\EOF &&
#			SIGNER=principal with number 1
#			KEY=FINGERPRINT
#			STATUS=G
#			NONCE_STATUS=OK
#			EOF
#			sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
#		) | sed -e "s|FINGERPRINT|$FINGERPRINT|" >expect &&
#	
#		noop=$(git rev-parse noop) &&
#		ff=$(git rev-parse ff) &&
#		noff=$(git rev-parse noff) &&
#		grep "$noop $ff refs/heads/ff" dst/push-cert &&
#		grep "$noop $noff refs/heads/noff" dst/push-cert &&
#		test_cmp expect dst/push-cert-status
#	
