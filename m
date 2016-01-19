From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH v4 1/1] contrib/subtree: Add a test for subtree rebase that loses commits
Date: Mon, 18 Jan 2016 20:53:39 -0600
Message-ID: <87wpr6l1os.fsf@waller.obbligato.org>
References: <CAPig+cTMAnbyT3-FFN4juUooosiydOCX-ETwTghpnKoOeXcMpQ@mail.gmail.com>
	<047e625a28954b8fd79225b55cab7620cb5f3b1f.1453074191.git.greened@obbligato.org>
	<CAPig+cS6ouc+kdJaz10M2AApPoDODDcgDX9Azz8ih=4zxxD2zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 03:53:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLMQc-0004HE-QK
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 03:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756941AbcASCxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 21:53:51 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:33716 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756882AbcASCxt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 21:53:49 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aLMRu-00075V-G9; Mon, 18 Jan 2016 20:55:14 -0600
In-Reply-To: <CAPig+cS6ouc+kdJaz10M2AApPoDODDcgDX9Azz8ih=4zxxD2zg@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 18 Jan 2016 13:10:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Eric Sunshine <sunshine@sunshineco.com> writes: > On Sun,
   Jan 17, 2016 at 6:43 PM, David Greene <greened@obbligato.org> wrote: >> This
    test merges an external tree in as a subtree, makes some commits >> on top
    of it and splits it back out. In the process the added commits >> are lost
    or the rebase aborts with an internal error. The tests are >> marked to expect
    failure so that we don't forget to fix it. >> >> Signed-off-by: David A.
   Greene <greened@obbligato.org> >> --- >> diff --git a/t/t3427-rebase-subtree.sh
    b/t/t3427-rebase-subtree.sh > 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284342>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Jan 17, 2016 at 6:43 PM, David Greene <greened@obbligato.org> wrote:
>> This test merges an external tree in as a subtree, makes some commits
>> on top of it and splits it back out.  In the process the added commits
>> are lost or the rebase aborts with an internal error.  The tests are
>> marked to expect failure so that we don't forget to fix it.
>>
>> Signed-off-by: David A. Greene <greened@obbligato.org>
>> ---
>> diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
>> @@ -0,0 +1,70 @@
>> +# FAILURE: Does not preserve master4 and master5.
>> +test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto' '
>> +       reset_rebase &&
>> +       git checkout -b rebase-preserve-merges master &&
>> +       git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
>> +       git commit -m "Empty commit" --allow-empty &&
>> +       git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
>> +       verbose "$(last_commit_message)" "files_subtree/master5"
>
> Hmm, does this test succeed? If it does, it's only by accident.
> verbose() is just a helper for printing the the expression being
> tested upon failure, but you still need to supply a proper expression
> for testing. It is intended to be used like this:
>
>     verbose test "$(last_commit_message)" = files_subtree/master5
>
> Same comment applies to the remaining tests.

Blast.  Yes, it did pass (expect failure) but it's definitely wrong.  On
to v5!

                           -David
