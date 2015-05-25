From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Mon, 25 May 2015 14:12:55 -0700
Message-ID: <xmqq1ti4bbu0.fsf@gitster.dls.corp.google.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<xmqqfv6nchmf.fsf@gitster.dls.corp.google.com>
	<xmqq382ncgmb.fsf@gitster.dls.corp.google.com>
	<CAJ80savVjb3_iKhNWPjQNK72DL7eq5YkbjWWG-1Gkx5+LOjzeg@mail.gmail.com>
	<CAJ80sas_D-6z4MvuFvvjoX7U_bM6b3brCo4rvYFCUfTmKS=6bA@mail.gmail.com>
	<xmqqpp5obotk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 23:13:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwzgF-0007CH-NN
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 23:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbbEYVM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 17:12:58 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:32803 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbbEYVM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 17:12:57 -0400
Received: by iebgx4 with SMTP id gx4so78984729ieb.0
        for <git@vger.kernel.org>; Mon, 25 May 2015 14:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2e8rphZksJpZjejMrjejbOM7lftTQdB3a/x04adOOZY=;
        b=OB2bNv+nArFMthiFuTgH9vY2DSlm0ZVQu9urM9LSrcUcLc6flB8MQxhZQRLoIgaNOP
         /+aKUev0oRs9O0aaTwfJyYo2klQ/VLdkGfXSyJKVEZPXrOYejkfeNvPVys9GxZbPYtNk
         opkveUVGXx6s5KwvfLwQnTbcLHH8XDxFsX5KS0K3aG2y4KBHczuD7JyK4wBWN5COz1rC
         ziBOivlsRh4am6BN426S0WATzuiY2tVikWPyUb2S8IUbiiAPkGZjLebqfKE3GHZa79bh
         1jGqOSa6g+o2HmeJewn1wvXc5R9YSfYAKUvAa52N7/5eEroHCuZvPkWBErCvQELCEFHL
         Bs7g==
X-Received: by 10.107.135.68 with SMTP id j65mr482810iod.91.1432588376704;
        Mon, 25 May 2015 14:12:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id fs5sm6799968igb.0.2015.05.25.14.12.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 May 2015 14:12:56 -0700 (PDT)
In-Reply-To: <xmqqpp5obotk.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 25 May 2015 09:32:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269910>

Junio C Hamano <gitster@pobox.com> writes:

> Allen Hubbe <allenbh@gmail.com> writes:
>
>> Looking closer at this and the other test cases, they are inconsistent
>> about using ".mailrc", "~/.mailrc", and "$(pwd)/.mailrc".  This would
>> add another one, "$HOME/.mailrc".
>
> In t9001, I see two tests on mailrc:
> ...
> So I do not see any reason to change most of these; except that the
> target of 'echo' should be changed from ~/.mailrc to $HOME/.mailrc.

FYI, I have tentatively queued this on top of your patch.  Please
see "git log master..cf954075" to double check.

Thanks.

-- >8 --

Subject: [PATCH] t9001: write $HOME/, not ~/, to help shells without tilde expansion

Even though it is in POSIX, we do not have to use it, only to hurt
shells that may lack the support.

The .mailrc test tries to define an alias in .mailrc in the home
directory by shell redirection, and then tries to see ~/.mailrc in
config is tilde-expanded by Git without help from shell.  So the
creation should become $HOME/ to be portable for shells that may
lack tilde expansion but the reference should be done as "~/.mailrc".

The sendmail one refers to the file from the configuration with full
path, so it does not need to know that $HOME during the test run is
set to the current "trash" directory.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9001-send-email.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index b04d263..c5c6867 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1537,7 +1537,7 @@ test_expect_success $PREREQ 'sendemail.aliasfiletype=mailrc' '
 
 test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
 	clean_fake_sendmail &&
-	echo "alias sbd  someone@example.org" >~/.mailrc &&
+	echo "alias sbd  someone@example.org" >"$HOME/.mailrc" &&
 	git config --replace-all sendemail.aliasesfile "~/.mailrc" &&
 	git config sendemail.aliasfiletype mailrc &&
 	git send-email \
@@ -1552,7 +1552,7 @@ test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
 test_expect_success $PREREQ 'sendemail.aliasfiletype=sendmail' '
 	clean_fake_sendmail && rm -fr outdir &&
 	git format-patch -1 -o outdir &&
-	cat >>~/.tmp-email-aliases <<-\EOF &&
+	cat >>./.tmp-email-aliases" <<-\EOF &&
 	alice: Alice W Land <awol@example.com>
 	bob: Robert Bobbyton <bob@example.com>
 	# this is a comment
-- 
2.4.1-455-ga49e496
