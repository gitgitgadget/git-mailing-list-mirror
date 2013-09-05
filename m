From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v4 7/8] update-ref: support multiple simultaneous updates
Date: Thu, 05 Sep 2013 16:32:34 -0400
Message-ID: <5228EA62.7030606@kitware.com>
References: <cover.1378142795.git.brad.king@kitware.com> <cover.1378307529.git.brad.king@kitware.com> <ad27a96b70198e837ac61995a1328960e10072bc.1378307529.git.brad.king@kitware.com> <xmqqsixkmonq.fsf@gitster.dls.corp.google.com> <52279107.2070205@kitware.com> <xmqqd2ool1ks.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 22:34:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHgGO-00070A-IC
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 22:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757678Ab3IEUee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 16:34:34 -0400
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:54192 "HELO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757640Ab3IEUeb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Sep 2013 16:34:31 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]) (using TLSv1) by na3sys009aob131.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUijq1w4CIXplV6V/DqBS4U6Nh9GkOizE@postini.com; Thu, 05 Sep 2013 13:34:31 PDT
Received: by mail-oa0-f43.google.com with SMTP id i10so2995354oag.30
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 13:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=z35wsUu6CekmLoT+OiqTNRv/Awg+c6Ias2WPjGVhtUY=;
        b=mCK0UI5MvJ5AnGouvZwuguHOKh1SeMrjtBGxIAgDEmmx6CVVUGdgz4QZAfhwS0rfN7
         qH+N7C7KgvVRslZ0/UlRyYAWmkutPGBNGeQv03GkA+BRN8QMBMlYotIx7p1Yfn5KVWPt
         qPDnhnojG/kS7N2WcosfvOz9J65I9RAfx8ns779Du8nPjdEPwCuP1qRYmJe8gqNs3sI8
         /+ApFgpcnkvA++WrMMsftHEF0LSfJb9jeCa2EJ2NGkydf7mARf/9m6Fn3hzx+IsuaMeE
         pimoM7NTna020BrZfOhGLTWGdy1sTeER4otqFNXjQlwbQK2KU2XaHKcX81caqNUB0Xcn
         whjw==
X-Gm-Message-State: ALoCoQl46sE3iy5PmAqOtCE0iWgEp0KedfiRbnDVsBMiBccsHwCOl0MgB8x7u9v9TxsyecOLMpbYWmXfxR/yYNp404GteY6dmpLv1xtWtvdS7esP7UHp/y7U87QgU9AIlgn1k7vT6b4ZqQF425Li6AnmoObvzlVOdA==
X-Received: by 10.60.45.102 with SMTP id l6mr7866660oem.36.1378413270701;
        Thu, 05 Sep 2013 13:34:30 -0700 (PDT)
X-Received: by 10.60.45.102 with SMTP id l6mr7866655oem.36.1378413270603;
        Thu, 05 Sep 2013 13:34:30 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id r3sm32870110oep.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Sep 2013 13:34:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <xmqqd2ool1ks.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233990>

On 09/04/2013 05:27 PM, Junio C Hamano wrote:
> I am not saying the above is the best format, but the point is that
> the mode of the operation defines the structure

Great, thanks for your comments.  Based on that I've prototyped a
new format.  Rather than jumping straight to the patch, here is my
proposed format documentation for review:

-------------------------------------------------------------------------
With `--stdin`, update-ref reads instructions from standard input and
performs all modifications together.  Specify commands of the form:

	create SP <ref> SP <newvalue> LF
	update SP <ref> SP <newvalue> [SP <oldvalue>] LF
	delete SP <ref> [SP <oldvalue>] LF
	verify SP <ref> [SP <oldvalue>] LF
	option SP <opt> LF

Quote fields containing whitespace as if they were strings in C source
code.  Alternatively, use `-z` to specify commands without quoting:

	create SP <ref> NUL <newvalue> NUL
	update SP <ref> NUL <newvalue> NUL [<oldvalue>] NUL
	delete SP <ref> NUL [<oldvalue>] NUL
	verify SP <ref> NUL [<oldvalue>] NUL
	option SP <opt> NUL

Lines of any other format or a repeated <ref> produce an error.
Command meanings are:

create::
	Create <ref> with <newvalue> only if it does not exist.

update::
	Update <ref> to be <newvalue>, verifying <oldvalue> if given.
	Specify a zero <newvalue> to delete a ref and/or a zero
	<oldvalue> to make sure that a ref does not exist.

delete::
	Delete <ref>, verifying <oldvalue> if given.

verify::
	Verify <ref> against <oldvalue> but do not change it.  If
	<oldvalue> zero or missing, the ref must not exist.

option::
	Specify an option to take effect for following commands.
	Valid options are `deref` and `no-deref` to specify whether
	to dereference symbolic refs.

Use 40 "0" or the empty string to specify a zero value, except that
with `-z` an empty <oldvalue> is considered missing.

If all <ref>s can be locked with matching <oldvalue>s
simultaneously, all modifications are performed.  Otherwise, no
modifications are performed.  Note that while each individual
<ref> is updated or deleted atomically, a concurrent reader may
still see a subset of the modifications.
-------------------------------------------------------------------------

Thanks,
-Brad
