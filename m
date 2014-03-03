From: Guanglin Xu <mzguanglin@gmail.com>
Subject: Re: [PATCH v2] branch.c: change install_branch_config() to use skip_prefix()
Date: Mon, 3 Mar 2014 09:41:42 +0800
Message-ID: <CAATe9uhK88Gy4_EJTjJ=8ULKY0ADGrBkRArwBiVncf_2exWZEQ@mail.gmail.com>
References: <1393775755-15359-1-git-send-email-mzguanglin@gmail.com>
	<CAPig+cRy2Jt_3DAS=ARzN-8HT3rdMCSGP5QfU8sJZGwqsJTG3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 02:41:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKHt7-0003QJ-4q
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 02:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbaCCBlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 20:41:44 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:54626 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbaCCBln convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2014 20:41:43 -0500
Received: by mail-ig0-f174.google.com with SMTP id h18so6505125igc.1
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 17:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=CH4MTxmZJom6u96ql9OZ4oPx00blma+tSy31MgyHmLA=;
        b=Yl9H1EE9r/3SasPB7MEw9R80VRqnOGlEBlSztEc9MdW1LK4OOBFuVEHztulKfMq+Oo
         mfXY/jD3YAnYXcSS6gt0DerhC52nvK0X3ubARLvSA5YJQeXTEvFlx7mDTowF6tlzEEFg
         f8RCm5QUqPlLkYxv+2YaNq5mOxxYsAb8jfoBGL2GryyOVM3AtfczqV4zvJITf6owcunl
         XNkSFTG6al7zcTjBdxmP7vn0o2hkOvbQ6LcRqfRpWI1qE0z/E1U6oDu3cRKNJLgYDIuo
         ZXum5VLV6TXN6jLp+idVvF6l45d5bFKfgRmt0Xq9hvJRcmeoAfrwaVHiJQHs22C1fOnz
         TD3g==
X-Received: by 10.50.40.37 with SMTP id u5mr18842594igk.30.1393810902659; Sun,
 02 Mar 2014 17:41:42 -0800 (PST)
Received: by 10.64.14.135 with HTTP; Sun, 2 Mar 2014 17:41:42 -0800 (PST)
In-Reply-To: <CAPig+cRy2Jt_3DAS=ARzN-8HT3rdMCSGP5QfU8sJZGwqsJTG3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243172>

2014-03-03 6:56 GMT+08:00 Eric Sunshine <sunshine@sunshineco.com>:
> Thanks for the submission. Comments below to give you a taste of the
> Git review process...
>
> On Sun, Mar 2, 2014 at 10:55 AM, Guanglin Xu <mzguanglin@gmail.com> wrote:
>> Change install_branch_config() to use skip_prefix() and make it conform to the usage of previous starts_with(). This is because the proper usage of skip_prefix() overrides the functionality of starts_with(). Thorough replacements may finally remove the starts_with() function and reduce  code redundency.
>
> Justifying a change is certainly a good idea, however, the above
> reasoning for this particular change is off mark. See below.
>
> Also, wrap commit message lines to 65-70 characters or so.
>
>> Signed-off-by: Guanglin Xu <mzguanglin@gmail.com>
>> ---
>>  branch.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/branch.c b/branch.c
>> index 723a36b..ca4e824 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -50,7 +50,7 @@ static int should_setup_rebase(const char *origin)
>>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>>  {
>>         const char *shortname = remote + 11;
>> -       int remote_is_branch = starts_with(remote, "refs/heads/");
>> +       int remote_is_branch = (NULL != skip_prefix(remote ,"refs/heads/"));
>
> This actually makes the code more difficult to read and understand.
> There's a more fundamental reason to use skip_prefix() here. See if
> you can figure it out. (Hint: shortname)

Hi Eric,

Thanks for your hint. Now I wonder this idea is just to remove the
magic code of 11.

So I would like to replace this line:
const char *shortname = remote + 11;
by this line:
const char *shortname = skip_prefix(remote, "refs/heads/");

and keep the next line unchanged.

Am I right?
>
>>         struct strbuf key = STRBUF_INIT;
>>         int rebasing = should_setup_rebase(origin);
>>
>> --
>> 1.9.0
>>
>> Hi,
>> I am Guanglin Xu. I plan to apply for GSoC 2014.
>>
>> This patch is in accordance with the idea#2 of GSoC2014 Microproject. Any comments are welcomed.
>
> This sort of commentary, which is appropriate to the email discussion
> but not meant for permanent project history, should be placed
> immediately below the "---" line following your sign-off.

Apologize for bad format. I am going to fix it by PATCH v3.

Guanglin
