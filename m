From: "Ulrik Sverdrup" <ulrik.sverdrup@gmail.com>
Subject: Re: git merge vs git commit
Date: Wed, 10 Sep 2008 19:42:44 +0200
Message-ID: <a1b6cb1b0809101042x2d097524q7b95d4164141a443@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 10 19:44:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdTjP-0005FR-2s
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 19:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbYIJRmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 13:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbYIJRmq
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 13:42:46 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:54565 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbYIJRmq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 13:42:46 -0400
Received: by yw-out-2324.google.com with SMTP id 9so480985ywe.1
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 10:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=xU1NpOnAqLVgv/CxnWcudkn+4w8d82rnmBN0fjlgPS8=;
        b=M0ogKBt4+KCMUV1v+RUe93J72v06PF+3NmgXH0QakntCgLoCgu608+p4ojfSP8mUzT
         bUnHTOYAtSx9WEx+h/QRzjGlqSg2WQ7n5i2LC0buhdpMRtLTatriQ14MCI7B4K4hSnlM
         Q3vP6T4kcqE7SywfeKsJYm/xyyLEkX0cpwkTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=TshZBzfNsX3Tf9B4vFMtbAq28rVB8Rfzotk/Fv3uN8hdTk9pIZDTahvb74oqt5nMvu
         1RLFRwMYEAtj7uKtam5CciFkWZUlm/Zp3e5upeqYndjmTVdxvQeHtQr6a9hmopUTeFSc
         Y/DpvwNI25Yq+4C4xrZMwgJIRbPvEiOZwoWac=
Received: by 10.100.4.1 with SMTP id 1mr1783222and.149.1221068564724;
        Wed, 10 Sep 2008 10:42:44 -0700 (PDT)
Received: by 10.100.41.13 with HTTP; Wed, 10 Sep 2008 10:42:44 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95542>

Matthieu Moy <Matthieu.Moy@imag.fr>:
>
>>Russell King <rmk@arm.linux.org.uk> writes:
>>
>> Hi,
>>
>> Using git 1.5.4.5, I notice that the result from git merge and git commit
>> are different in an unexpected way.
>>
>> Take the following tree:
>>
>>      B---C---D---E2
>>     /
>>   -A1
>>     \
>>      F---G---H---I3
>>
>> (letters represent commits, numbers represent where the references are).
>>
>> Your current head is '1', and you want to merge branches '2' and '3', so
>> you use:
>>
>>      git merge 2 3
>
>AAUI, "git merge 2 3" doesn't mean "merge 2 and 3 together", but
>"merge 2 and 3 with the current HEAD". So, what you wanted was :
>
>git checkout 1
>git merge 2
>
>And what you did was an octopus merge of A, E and I (which ends up
>being the same since A is anyway the common ancestor of E and I).
>
>Now, this doesn't explain why the conflicted merge gives a result
>different from the other.
>

(I'm not on the list, please CC)

Reading the whole thread I think we have an explanation: octupus-merge
learned to remove reduntant parents and does so in the clean merge
case, but merge in general does not it; this is what happens in the
conflict case.

However it remains that three parents are to be expected with the
given user action

Ulrik Sverdrup
