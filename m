From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH v3 03/13] add the basic data structure for line level 
	history
Date: Sun, 18 Jul 2010 22:35:42 +0800
Message-ID: <AANLkTilba9j1IfPbWuNUIxG-fkPjDIKAWubDneVJu4_N@mail.gmail.com>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
	<1278829141-11900-3-git-send-email-struggleyb.nku@gmail.com>
	<AANLkTim5m2vG3ZiveRcRIGLVszu9mFruTJ2B_6lsqkGH@mail.gmail.com>
	<7vr5j8bq5x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 16:35:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaUy5-0002Lb-I3
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 16:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003Ab0GROfo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 10:35:44 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58156 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab0GROfn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jul 2010 10:35:43 -0400
Received: by qwh6 with SMTP id 6so1334059qwh.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7mWvo7Vm+eKahMQbdW983b4Qgs03qBRlUYcq6eCIIbg=;
        b=AD3MPENk5msDxLrG7KvSLWuW7Ky4nUts+HsDmKKHKE08gFw1HQVqojjJCIBNyekj24
         YDpRKf9O20oLXShFUaxMtk6mMssSpwr7Cmt+OvYYW7mra9n4PGW6wePZrPNzdP61Zssm
         jbSFRi/JdzOyAPyoUEnd12KHzCt9GTvlMaqLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M/jGHyY7h5CgAxX4BE1an8/UKk2mnRBt4K12yLwdRGHYd7lyvPWs3mACKeaL4vBD8s
         HuEzSyvCmVolXIpnAX0tknsMRqADwVGr+GV3QNyhgmGWh0VUpcNV6p2tqZYg2FP72gqs
         6syCRFh6G4QWLuyIrtJDFUihbwWOAOY9f9O0o=
Received: by 10.224.60.19 with SMTP id n19mr3123298qah.248.1279463742466; Sun, 
	18 Jul 2010 07:35:42 -0700 (PDT)
Received: by 10.229.79.148 with HTTP; Sun, 18 Jul 2010 07:35:42 -0700 (PDT)
In-Reply-To: <7vr5j8bq5x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151212>

Hi Junio,
On Tue, Jul 13, 2010 at 12:50 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> diff --git a/diffcore.h b/diffcore.h
>> index 491bea0..13d8e93 100644
>> --- a/diffcore.h
>> +++ b/diffcore.h
>> @@ -23,6 +23,7 @@
>> =A0#define MINIMUM_BREAK_SIZE =A0 =A0 400 /* do not break a file sma=
ller than this */
>>
>> =A0struct userdiff_driver;
>> +struct diff_options;
>
> Why???

The line:
extern void diffcore_rename(struct diff_options *);
later in this file use it. So, forward declare it.

>>
=2E..
>> =A0#define DECORATE_SHORT_REFS =A01
>> =A0#define DECORATE_FULL_REFS =A0 2
>> @@ -68,7 +69,8 @@ struct rev_info {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cherry_pick:1,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bisect:1,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ancestry_path:1,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 first_parent_only:1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 first_parent_only:1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 line:1;
>
> Is this really a traversal flag that affects how the history is walke=
d?

Hmm, a 'line' means topologically traverse at least. So, I added it
here. And I can't find a better place to put it. :)

I have changed my code according your comments, thanks a lot!

--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
