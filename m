From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/10] Add string-specific memory pool
Date: Thu, 12 Aug 2010 16:30:47 -0500
Message-ID: <20100812213047.GH2029@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100809223442.GA4429@burratino>
 <7vmxsru4ny.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 23:32:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjfNz-0001Lt-W5
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 23:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760707Ab0HLVcX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 17:32:23 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40141 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106Ab0HLVcW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 17:32:22 -0400
Received: by qwh6 with SMTP id 6so1982030qwh.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 14:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=l4L8M+e61jZw1NrEzIBreCLBuZEHGbe69Brnywjdrj4=;
        b=qlfYj3JvRrumwQYU/66a52+Y8ZLDUtd68imBeYX+5EDurpI4UakzuzDkD3NVqfE3vn
         DGofaAzVRh84Og+kjaKYFpP4REv8/6930sdT4LMfB9iYfyenJcZPgKuuq9Wb+S4tGb18
         1/FSqSXfIpO5KpUefBHvYhyVsDM4KOr+b9JuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LeC7shftED7NtLx/1whJHkheQmtC07Bm1HhoZk6KIKSUdWQnzHsvZ1KUHjSqLvi6Yn
         793JlHueuzjxmSo1j9n1rn00c5CJHUDxCh932cfPGCdBwk5e4dNezhTklZr+ep8NF90t
         cuGW8c6tUdXDBqX/INCBPYRZSH989Ji9rXbz4=
Received: by 10.224.37.78 with SMTP id w14mr418042qad.75.1281648741881;
        Thu, 12 Aug 2010 14:32:21 -0700 (PDT)
Received: from burratino ([66.99.3.154])
        by mx.google.com with ESMTPS id t18sm2402351qco.20.2010.08.12.14.32.18
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 14:32:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmxsru4ny.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153421>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> diff --git a/Makefile b/Makefile
>> index e7c33ec..24103c9 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -415,6 +415,7 @@ TEST_PROGRAMS_NEED_X +=3D test-path-utils
>>  TEST_PROGRAMS_NEED_X +=3D test-run-command
>>  TEST_PROGRAMS_NEED_X +=3D test-sha1
>>  TEST_PROGRAMS_NEED_X +=3D test-sigchain
>> +TEST_PROGRAMS_NEED_X +=3D test-string-pool
>>  TEST_PROGRAMS_NEED_X +=3D test-treap
>>  TEST_PROGRAMS_NEED_X +=3D test-index-version
>
> Does your Makefile do the right thing to vcs-svn/*.[oa] upon "make cl=
ean"?

Good catch.  Here=E2=80=99s a fixup for patch 2 (=E2=80=9CIntroduce vcs=
-svn lib=E2=80=9D).

-- 8< --
Subject: vcs-svn: remove build artifacts on =E2=80=9Cmake clean=E2=80=9D

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/Makefile b/Makefile
index 2418820..24c4b3d 100644
--- a/Makefile
+++ b/Makefile
@@ -2184,8 +2184,8 @@ distclean: clean
 	$(RM) configure
=20
 clean:
-	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
-		builtin/*.o $(LIB_FILE) $(XDIFF_LIB)
+	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vc=
s-svn/*.o \
+		builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) -r bin-wrappers
--=20
