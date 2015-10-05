From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 43/43] refs: tests for db backend
Date: Mon, 05 Oct 2015 09:56:51 -0700
Message-ID: <xmqqh9m5z224.fsf@gitster.mtv.corp.google.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	<1443477738-32023-44-git-send-email-dturner@twopensource.com>
	<20151003173930.GA25904@spirit>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 18:56:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj94M-0005JN-B2
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 18:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbbJEQ4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 12:56:54 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36099 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbbJEQ4x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 12:56:53 -0400
Received: by pablk4 with SMTP id lk4so181065530pab.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Hj1fjQgFf7rs9bmaxu04b+GTqAO01j37277AKmSf2Xw=;
        b=bAuvZ6FhtbzhOusdCqUSwu2QAc6J2lH/J3lh/rImgqpheGRA4KNrNCaM6rq8EqWjXq
         wV/IuSbEyhwRET9F3zyIl3MePpoTUUWdr+oCN712XhEV+z8a3bMMwsj7l5OSAiiweEmf
         JGVQmW+B/cnhnLdnU4BwATzhwKYl38XM4/HRhNOBweI6yNlNsCv0Iu5F2RXnepx9aSRS
         XE4zwCnCY1DrJgo2ZW9miGLQkv4M5bZu/ofMawpnwa8nJgx0PNpBvrgQoRtehRnKI6+z
         LLrYJ0D2oLkuexRwXlH02jImr+Cqc9UDflp/HoEL8ni6Na2noE47uNhbI8xgh7mNgrss
         E8Qg==
X-Received: by 10.69.25.1 with SMTP id im1mr40657406pbd.102.1444064212721;
        Mon, 05 Oct 2015 09:56:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:60e8:cc09:ddf4:4eed])
        by smtp.gmail.com with ESMTPSA id u1sm28607056pbz.56.2015.10.05.09.56.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 09:56:51 -0700 (PDT)
In-Reply-To: <20151003173930.GA25904@spirit> (Dennis Kaarsemaker's message of
	"Sat, 3 Oct 2015 19:39:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279060>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On Mon, Sep 28, 2015 at 06:02:18PM -0400, David Turner wrote:
>> Add tests for the database backend.
>> 
>> Signed-off-by: David Turner <dturner@twopensource.com>
>> ---
>>  t/t1460-refs-be-db.sh        | 1103 ++++++++++++++++++++++++++++++++++++++++++
>>  t/t1470-refs-be-db-reflog.sh |  353 ++++++++++++++
>>  2 files changed, 1456 insertions(+)
>>  create mode 100755 t/t1460-refs-be-db.sh
>>  create mode 100755 t/t1470-refs-be-db-reflog.sh
>
> These break 'make test' on builds without the db backend. Maybe squash
> in something like the following:
>
> diff --git a/t/t1460-refs-be-db.sh b/t/t1460-refs-be-db.sh
> index f13b0f0..c8222ed 100755
> --- a/t/t1460-refs-be-db.sh
> +++ b/t/t1460-refs-be-db.sh
> @@ -9,6 +9,11 @@ test_description='Test lmdb refs backend'
>  TEST_NO_CREATE_REPO=1
>  . ./test-lib.sh
>  
> +if ! test -e ../../test-refs-be-lmdb; then
> +	skip_all="Skipping lmdb refs backend tests, lmdb backend not built"
> +	test_done
> +fi

The idea is sound, but $TRASH_DIRECTORY (i.e. $(cwd) there) is not
necessarily two subdirectories down from the build repository root
(cf. --root=<there> parameter to the test scripts), so you need to
account for that.

Thanks.
