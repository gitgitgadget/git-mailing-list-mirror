From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] use child_process_init() to initialize struct child_process
 variables
Date: Sun, 09 Nov 2014 14:49:58 +0100
Message-ID: <545F7106.7070300@web.de>
References: <54500212.7040603@web.de> <20141029172109.GA32234@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 09 14:50:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnSsv-00060m-RD
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 14:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbaKINuX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 08:50:23 -0500
Received: from mout.web.de ([212.227.17.11]:51993 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585AbaKINuW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 08:50:22 -0500
Received: from [192.168.178.27] ([79.253.168.90]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MA5if-1XtlLr3npZ-00BMe4; Sun, 09 Nov 2014 14:50:14
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141029172109.GA32234@peff.net>
X-Provags-ID: V03:K0:Z9E7dVfE9SuHD2OSdzAFm14ZQc4tnKdF7JW6xBqIz1zUel2PK6T
 MPK8pWU2+AYQkdVqByVsmSepT9tVUxrxCK4YzuntvdqtdC0x2JG+Z72e8xcelMPQawq56ar
 h8N8Ll/hb9MS10l3+ICI1WfFGvwTlF4x0zFCMJnwiQEBfwvtspS+NduI2pS/GJMTsH0AxSl
 GHtA7avbAs8lBLLb5Q5aQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.10.2014 um 18:21 schrieb Jeff King:
> On Tue, Oct 28, 2014 at 09:52:34PM +0100, Ren=C3=A9 Scharfe wrote:
>> diff --git a/trailer.c b/trailer.c
>> index 8514566..7ff036c 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -237,7 +237,7 @@ static const char *apply_command(const char *com=
mand, const char *arg)
>>   		strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
>>  =20
>>   	argv[0] =3D cmd.buf;
>> -	memset(&cp, 0, sizeof(cp));
>> +	child_process_init(&cp);
>>   	cp.argv =3D argv;
>>   	cp.env =3D local_repo_env;
>>   	cp.no_stdin =3D 1;
>=20
> I think this one can use CHILD_PROCESS_INIT in the declaration. I gue=
ss
> it is debatable whether that is actually preferable, but I tend to th=
ink
> it is cleaner and less error-prone.

Agreed, thanks.

-- >8 --
Subject: [PATCH] trailer: use CHILD_PROCESS_INIT in apply_command()

Initialize the struct child_process variable cp at declaration time.
This is shorter, saves a function call and prevents using the variable
before initialization by mistake.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 trailer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/trailer.c b/trailer.c
index 7ff036c..6ae7865 100644
--- a/trailer.c
+++ b/trailer.c
@@ -228,7 +228,7 @@ static const char *apply_command(const char *comman=
d, const char *arg)
 {
 	struct strbuf cmd =3D STRBUF_INIT;
 	struct strbuf buf =3D STRBUF_INIT;
-	struct child_process cp;
+	struct child_process cp =3D CHILD_PROCESS_INIT;
 	const char *argv[] =3D {NULL, NULL};
 	const char *result;
=20
@@ -237,7 +237,6 @@ static const char *apply_command(const char *comman=
d, const char *arg)
 		strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
=20
 	argv[0] =3D cmd.buf;
-	child_process_init(&cp);
 	cp.argv =3D argv;
 	cp.env =3D local_repo_env;
 	cp.no_stdin =3D 1;
--=20
2.1.3
