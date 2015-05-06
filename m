From: Danny Lin <danny0838@gmail.com>
Subject: Re: [PATCH] contrib/subtree: fix linefeeds trimming for cmd_split()
Date: Thu, 7 May 2015 02:58:21 +0800
Message-ID: <CAMbsUu4bix6pJA4OOoMSwYu0M6nO1+aZ7RLXU5sSOdOevN_Wzw@mail.gmail.com>
References: <CAMbsUu6xZrMu_jrV=jR4XNLf1UXLApBiAWJiWJuKRb4xN90QJQ@mail.gmail.com>
	<xmqq4mnqet5d.fsf@gitster.dls.corp.google.com>
	<CAMbsUu6=U92TRo-UeOL1qtaTipMQFzD+m+wM7sn1o-AjD6LJBw@mail.gmail.com>
	<xmqqwq0lbp87.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git develop <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 20:58:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq4WZ-0000E2-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 20:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbbEFS6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 14:58:22 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33259 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbbEFS6W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 14:58:22 -0400
Received: by qgdy78 with SMTP id y78so9609394qgd.0
        for <git@vger.kernel.org>; Wed, 06 May 2015 11:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vVAQj4eb1JWCv2IYA1l4acoxN4Y7gwo0ViiQB1w9xx4=;
        b=EuNCafoOV/mNyTPqWzVR1191oTVHhWVKvx1G6Ge4MIzXRQJs1ZVw1AxlNdJHVGQE0P
         PY7eRRIZxChkAoliCD2iDqNH3QyQ6aYWfz9ctfX0mlxQF7NFGbwFYZt0VmLqVJCWWJut
         iaG55+MFQGxF69AiVoqGyEINZHTvR3ImzULOpiVrnPSyXwB11f968TR45JIWSa9b4+nz
         QV6eHPweEapEz3GdLNoeJfnrANZff0vLBXnqJ9q48BlPFj6oX1EqPrGp3sZ3ZPERSe4j
         zCRFM2nEbSz/Ch58zVlzQm7BdUYZopW59RZ5bsTBVqHZlT7EVCaXRew7JO/RqJJjKOut
         Y2uw==
X-Received: by 10.140.129.65 with SMTP id 62mr253837qhb.102.1430938701336;
 Wed, 06 May 2015 11:58:21 -0700 (PDT)
Received: by 10.140.98.145 with HTTP; Wed, 6 May 2015 11:58:21 -0700 (PDT)
In-Reply-To: <xmqqwq0lbp87.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268480>

cmd_split() prints a CR char by assigning a variable
with a literal CR in the source code, which could be
trimmed or mis-processed in some terminals. Replace
with $(printf '\r') to fix it.

Signed-off-by: Danny Lin <danny0838@gmail.com>
---
 contrib/subtree/git-subtree.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index fa1a583..3a581fc 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -596,10 +596,11 @@ cmd_split()
     revmax=$(eval "$grl" | wc -l)
     revcount=0
     createcount=0
+    CR=$(printf '\r')
     eval "$grl" |
     while read rev parents; do
         revcount=$(($revcount + 1))
-        say -n "$revcount/$revmax ($createcount)
"
+        say -n "$revcount/$revmax ($createcount)$CR"
         debug "Processing commit: $rev"
         exists=$(cache_get $rev)
         if [ -n "$exists" ]; then
-- 
2.3.7.windows.1



2015-05-07 1:16 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Danny Lin <danny0838@gmail.com> writes:
>
>> If I run with:
>> printf "Hello, world1\r"
>> printf "Hello, world2\r"
>> printf "Hello, world3\r"
>> printf "Hello, world4\r"
>>
>> I get this on the screen:
>> Hello, world4
>>
>> I don't see a problem in 'git fetch' or 'git checkout'
>>
>> Maybe using printf is the way to go?
>
> Yes.  Thanks.
