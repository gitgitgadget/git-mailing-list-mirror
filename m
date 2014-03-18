From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] fsck.c:fsck_commit() use starts_with() and skip_prefix()
Date: Tue, 18 Mar 2014 19:12:48 -0400
Message-ID: <CAPig+cQko2fdCVmNyTufpGW=RRCxVt5G4xdWC7OrQmC9nXfKzg@mail.gmail.com>
References: <1395182512-17179-1-git-send-email-darrazo16@gmail.com>
	<CAPig+cRoRzZKjW3cY86iQxz9iZ_TKT-yyu=6Va5aV_DsCAQquA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Othman Darraz <darrazo16@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 00:12:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ3Bm-0008Lj-OH
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 00:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758548AbaCRXMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 19:12:49 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:44857 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758531AbaCRXMt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 19:12:49 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so21017144ykt.4
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 16:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=LNcJjdKkVUs4jsuoXXIeFaXFDU/H5ZFJ4oKCN0k/Sw8=;
        b=ALD6emZxg36uHShLW6gMrYH4NWlTDIGF28e59SOyP/voiPocGWLRVelr3/NqanpoCh
         vktPASlotGYCDhAwqHjyQbkTMB9JDDaGCxk9SiYwRLmURC3xdc5YvyOfgdojvRS/7BIS
         j8X4W0AkIdg3IvW3j/6UtZZ6sRU51rZf2l7uhjfannMvVMv0tX7mzZ2K8jYmuNS1jGDI
         AJYd9r45wPAzBh3SkgKfJgr9anQQyslD2FW9rpS4IlcOX3BMBPhJYnMqiCj/yaYBcDKe
         dKpCl9PucXybYWvWUXHb0D9Hw79kVrfk27ruph1A32nSgnjICqM6X96utDiDIC4SOL97
         1a1w==
X-Received: by 10.236.132.48 with SMTP id n36mr54898yhi.149.1395184368415;
 Tue, 18 Mar 2014 16:12:48 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 18 Mar 2014 16:12:48 -0700 (PDT)
In-Reply-To: <CAPig+cRoRzZKjW3cY86iQxz9iZ_TKT-yyu=6Va5aV_DsCAQquA@mail.gmail.com>
X-Google-Sender-Auth: u40lJQPNfrK1sGLUhjlgG3chPrM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244395>

On Tue, Mar 18, 2014 at 7:09 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> diff --git a/fsck.c b/fsck.c
>> index 64bf279..5eae856 100644
>> --- a/fsck.c
>> +++ b/fsck.c
>> @@ -290,7 +290,7 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>>         int parents = 0;
>>         int err;
>>
>> -       if (memcmp(buffer, "tree ", 5))
>> +       if (starts_with(buffer, "tree "))
>>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
>>         if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
>
> One of the reasons for using starts_with() rather than memcmp() is
> that it allows you to eliminate magic numbers, such as 5. However, if
> you look closely at this code fragment, you will see that the magic
> number is still present in the expression 'buffer+5'. starts_with(),
> might be a better fit.

Of course, I meant "skip_prefix() might be a better fit".
