From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/5] git-p4: add support for large file systems
Date: Wed, 09 Sep 2015 13:44:27 -0700
Message-ID: <xmqqtwr35nmc.fsf@gitster.mtv.corp.google.com>
References: <1441799950-54633-1-git-send-email-larsxschneider@gmail.com>
	<1441799950-54633-5-git-send-email-larsxschneider@gmail.com>
	<xmqq37yn7bni.fsf@gitster.mtv.corp.google.com>
	<353BE0F5-8262-4094-95E6-982C29570F6B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 22:44:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZmEL-0006ZK-RE
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 22:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbbIIUoa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2015 16:44:30 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34159 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbbIIUo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 16:44:29 -0400
Received: by padhy16 with SMTP id hy16so20334460pad.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 13:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=c/BRUEO/p9W7d1Qsfro/6XSJjfRed/ewg9CyQvZstGs=;
        b=GAhpS+/coeMhiWk3eQhnhr54hrtJIT2K0KZQHV3b3fiASe91gJsyVY2C0rxYsiALYo
         gJHcPGKEcAvMaQFYBk1pH6KTepTm6KWQl/O14N0j6pKLhg11fxMFqftPw8coCNc1Ega0
         6JSmByTkbkAFDfcHQ7K+jDpEGDzUIg9126uJFcBP+J9A/nCK+WtX+DP99bkuseG/+0nV
         JPyZXibko9Yi8kailzT6Naz7rqwam/bCiE8UjkKL8OcpdKulBMMV2HLWiOy2vCDlz/Tb
         TOEWA1oppkVXJnkqUaH2OsIstD01IlM3QPB7Pz0LMP/4PLqCD079DtFsLNyZO28A1MpA
         Zvxg==
X-Received: by 10.68.111.3 with SMTP id ie3mr75428507pbb.63.1441831468843;
        Wed, 09 Sep 2015 13:44:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:31c8:2790:408d:8446])
        by smtp.gmail.com with ESMTPSA id pg5sm7980950pdb.81.2015.09.09.13.44.27
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 09 Sep 2015 13:44:27 -0700 (PDT)
In-Reply-To: <353BE0F5-8262-4094-95E6-982C29570F6B@gmail.com> (Lars
	Schneider's message of "Wed, 9 Sep 2015 22:09:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277564>

Lars Schneider <larsxschneider@gmail.com> writes:

>> Also the exact format of these attributes entries looks like very
>> closely tied to GitHub LFS and not generic (for example, there is no
>> reason to expect that any large-file support would always use the
>> "filter" mechanism or the gitattributes mechanism for that
>> matter), =E2=80=A6
> Agreed. Instead of just the filter name I will replace everything
> after the pathname with a single git-p4 config value:

I actually was going to suggest not doing any such replacing.

You obviously need to cutomize the extensions list and specific
paths that hold large contents, but having .attributeDescription()
and .attributeFilter() that appear to be customizable sends a
message to the reader that the code aims to support things other
than GitHub LFS.  I somehow doubt that really is the case (as you
later mention, this would not work at all for solutions that are not
based on gitattributes in the first place).  It would be less
misleading if it is made painfully obvious that this part of the
code is about one specific backend.

> Well, you have a very good point here. From my point of view you can
> use git-p4 in two ways:
>
> _Way 1_: Your project is stored in Perforce and it will stay in
> Perforce. You use git-p4 on a regular basis to interact with the
> Perforce repository.
> _Way 2_: Your project is stored in Perforce and you want to migrate i=
t
> to Git. You use git-p4 once to perform the migration. Afterwards you
> never touch git-p4 or Perforce again.
>
> My large file system feature is intended to be used only for _Way 2_
> for exactly the reasons you mentioned. Would it still be OK to add
> this feature to git-p4? Maybe with a appropriate warning in the docs?

I could not tell, from the documentation that came in the patch,
which one between the above two ways is supported, which made me
assume that it aimed to support #1, as the desire to have a bidi
bridge seems to be fairly common.

It is a valid use case to migrate away and not looking back.  But
that is the only workflow that is supported, that fact needs to be
documented more clearly, I would think.

Otherwise those who expected a bidirectional bridge by reading the
documentation would be disappointed, possibly after wasting a lot of
time trying to figure out why their "git p4 submit" is not sending
the full large blob contents back to the depot.

Thanks.
