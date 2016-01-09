From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: for-each-ref output order change in 2.7.0
Date: Sun, 10 Jan 2016 02:59:22 +0530
Message-ID: <CAOLa=ZTUcmAjpC4nf_o7ZAHC3Asj9iwfKOOrJr90_kAyMbd22A@mail.gmail.com>
References: <CAGyf7-FSP3Z7HO=LpoQck8q9sSj3fGYCx1=gNa6fXEkovxAxHw@mail.gmail.com>
 <1674931730.811704.1452354002885.JavaMail.zimbra@imag.fr> <CAOLa=ZT7n8qCoS81iijf9vswWV+S8n7=4kmbKP0EAMnOenXwSg@mail.gmail.com>
 <56914AD2.9060303@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 09 22:30:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aI15n-00033b-M9
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 22:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099AbcAIV3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2016 16:29:53 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35816 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756012AbcAIV3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2016 16:29:53 -0500
Received: by mail-vk0-f45.google.com with SMTP id k1so208070931vkb.2
        for <git@vger.kernel.org>; Sat, 09 Jan 2016 13:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2cvWMCsMdrSCfK4WMLJzLdFKrsMcsxYfYj/vP9mi7jY=;
        b=N16EJbqOV+q03+ZmpHcK04ScTimFzPYnkK2ye9MiZr3H1AbjVADLzswhvXGa8rISe8
         vuOQphlpVrsmO3PIpHX3Op45+ISVZddWxPpGfEaPhKaAUqhxUJhcKca/WNnUR0g6oZlI
         aCQe0s06Z+TKkjZ1penjjjbbQviTp1+vA6yurYPhAeymxbnVqCBeQGKK0GvtAXo3aWNh
         tXPMCz11HInK70CbOiyWT42GXReWGVFw/Ossco+jtMHjuCYr2H1fDCAWENy1gUNrm9y7
         tMD1hC/pDDlcPY/2HoqglKn3mCPHPvf8OGIbPhab+iGop6ExzbgFJr2OfjNrKuXnRPGe
         SSMg==
X-Received: by 10.31.167.75 with SMTP id q72mr3783290vke.71.1452374992134;
 Sat, 09 Jan 2016 13:29:52 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Sat, 9 Jan 2016 13:29:22 -0800 (PST)
In-Reply-To: <56914AD2.9060303@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283607>

On Sat, Jan 9, 2016 at 11:30 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 09.01.2016 um 18:21 schrieb Karthik Nayak:
>>>>
>>>> (Note: The alphabetical-ness of the branch names is reversed, which
>>>> seems logical given my original sort was -committerdate. A
>>>> --sort=refname looks like this.
>>>>
>>>> refs/heads/!@#$% -> Tue Jan 3 17:00:51 2012 +1100
>>>> refs/heads/!@#% -> Tue Jan 3 17:04:06 2012 +1100
>>>> refs/heads/% -> Tue Jan 3 17:00:51 2012 +1100
>>>> refs/heads/@#$% - >Tue Jan 3 17:00:51 2012 +1100
>>>> refs/heads/@#% -> Tue Jan 3 17:00:51 2012 +1100
>>>>
>>>> That's probably more correct too.)
>>>>
>>>> Best regards,
>>>> Bryan Turner
>>
>>
>> This is correct as per the patch, But I'm wondering if this is desired.
>> I.E when sorting in reverse order should the fallback (alphabetical sort)
>> also be in reverse order?
>
>
> IMO, the fallback sorting should be in reverse order only when the user
> explicitley asked for reverse order. Just because committer date implies
> some "reverse" ordering should not imply that refs with the same committer
> date should also be listed in reverse alphabetical order.
>
> -- Hannes
>

I was thinking along the same lines. But do we want to expose the fallback to
the user (i.e let them choose if its reversible or not)? If not Its only a small
change required:

diff --git a/ref-filter.c b/ref-filter.c
index cc850b0..59d43d7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1554,7 +1554,7 @@ static int cmp_ref_sorting(struct ref_sorting
*s, struct ref_array_item *a, stru
                if (va->ul < vb->ul)
                        cmp = -1;
                else if (va->ul == vb->ul)
-                       cmp = strcmp(a->refname, b->refname);
+                       return strcmp(a->refname, b->refname);
                else
                        cmp = 1;
        }

I could send a patch, as soon as we decide if we want to stick something
simple like this or expose the fallback sort to the user.

-- 
Regards,
Karthik Nayak
