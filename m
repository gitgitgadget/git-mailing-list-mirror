From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [RFC 2/2] Future Proofing: Pass around pointers to either functions or data
Date: Wed, 30 Mar 2011 15:02:28 +0000
Message-ID: <429c193b-6bc6-4f13-bd69-af113a4bd145-mfwitten@gmail.com>
References: <3c6b883f-8860-4da2-b328-d912019a4145-mfwitten@gmail.com>
            <522d5a8a-a674-40bd-91bf-b5b8f88e0f78-mfwitten@gmail.com>
            <AANLkTi=nxA0BrLruQ9zc_SajH2ghpZX14Ra7QOo9fMBx@mail.gmail.com>
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 17:40:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4xV4-0003HH-3o
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 17:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582Ab1C3Pj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 11:39:57 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48129 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932236Ab1C3Pj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 11:39:56 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so1652095wwa.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:in-reply-to
         :references;
        bh=G0WJfSma1v3c3tkcB24nMJ/I17BjCPH+3lfksnmYuhE=;
        b=KqYwEj4PXQE/G7ziywy3H3Pt4dcEUHt7eZe9h5EsFncyRWFzpy2XmmOMOQkUnJigDR
         qlLKXkkJaLUfWE4DjbUDibBAdW+entHoHjD03caytFERFgB3Nznsq1qGluPe21JyO7Dg
         CFqQTNp9gQxAGR1ocnhL+Xr3jZXq7+JDFbb5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        b=q5W2R3EPN+6HeTic7nB1IsLYB+OkoxxYYDilCKYFPDBRJMRA0RyTWMXncaESOUCH+0
         UidyxUM3Gue1z1HT6wsOl4RGsCkvBQA7McCDjTy+HKfzLFG/w6Sf9y6CKomgF1EJi7HY
         oV/RcyUmBTAtXc+FGmVg8cySOQF3gW0ciQB1E=
Received: by 10.216.66.131 with SMTP id h3mr1332740wed.111.1301497407819;
        Wed, 30 Mar 2011 08:03:27 -0700 (PDT)
Received: from gmail.com (s214856783.online.de [87.106.138.84])
        by mx.google.com with ESMTPS id f52sm82935wes.11.2011.03.30.08.03.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 08:03:26 -0700 (PDT)
In-Reply-To: <AANLkTi=nxA0BrLruQ9zc_SajH2ghpZX14Ra7QOo9fMBx@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170390>

On Wed, 30 Mar 2011 12:09:46 +0200, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Tue, Mar 29, 2011 at 5:28 PM, Michael Witten <mfwitten@gmail.com> wrote:
>> +#define ALT_ODB_FN_INFO_FUNC(variable, function) \
>> +       union alt_odb_fn_info variable = { \
>> +               .func = (alt_odb_fn_cb)function \
>> +       }
>> +#define ALT_ODB_FN_INFO_DATA(variable, data_) \
>> +       union alt_odb_fn_info variable = { \
>> +               .data = data_ \
>> +       }
>
> We try to stay away from C99 features like this, as it doesn't work on
> all compilers we target.

How about changing it to this:

#define ALT_ODB_FN_INFO_FUNC(variable, function) \
	union alt_odb_fn_info variable; do { \
		variable.func = (alt_odb_fn_cb)function; \
	} while (0)
#define ALT_ODB_FN_INFO_DATA(variable, data_) \
	union alt_odb_fn_info variable; do { \
		variable.data = data_ \
	} while (0)
