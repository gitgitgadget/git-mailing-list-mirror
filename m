From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 19 Mar 2013 17:23:36 +0530
Message-ID: <CALkWK0nhmks6LqoALA8hrwkR00NjweyqV2RJ9-9V3q-bjgpsCg@mail.gmail.com>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net> <CACsJy8Ad7rKtMd-6BoBtbVa70F0AaJ+OUjEykNh344tPw7F7Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 12:54:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHv7Y-0003oM-GS
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 12:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144Ab3CSLx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 07:53:57 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:61496 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab3CSLx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 07:53:56 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so207957iee.11
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 04:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=eK9IiJLlo40mCPzX7IOwQA2mqMvvYEqIDFRdMfLgs+0=;
        b=F2CeA/CHVIzS33hl6+fOBacKvLTditj2Q6nVPt9GiAFIL3wPxD9LCLsHTMKKhoIwSO
         oUmiIFI73PHOPZ0hO2kBx0YR0Sjkq4WO2BfMnyfj0tp3jom9sMObclqPyPKPF9Pn3oQQ
         s1E70i1wWXWlpvLdHui4MmJCOcsh+/OO9iCrB4HBFoBXQj0ZVDm87zxziY57XeXv6Vyt
         f3eTYPdY3pPAP7TZILIsEd1O1gR1VRIrTgamtjVkCb3Y4k9PyHVSHGlzHdNqQPH56ba5
         z+UWoZypflpruX8iG/rZQ4W7lfTnsYkfEY6756NkzXQLQYBAHsSy2ibe9xSGf08K93LL
         zu+w==
X-Received: by 10.42.67.10 with SMTP id r10mr10924559ici.7.1363694036262; Tue,
 19 Mar 2013 04:53:56 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Tue, 19 Mar 2013 04:53:36 -0700 (PDT)
In-Reply-To: <CACsJy8Ad7rKtMd-6BoBtbVa70F0AaJ+OUjEykNh344tPw7F7Vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218506>

Duy Nguyen wrote:
> On Tue, Mar 19, 2013 at 12:08 AM, Jeff King <peff@peff.net> wrote:
>>> Is there a reason for the remote not being optional, or are we just
>>> waiting for a patch?  The only problem I can foresee is very minor:
>>> there is a ref with the same name as a remote; in this case, we'd have
>>> to specify both the remote and the ref.
>>
>> I think the ambiguity is a little more complex than that, because we
>> cannot enumerate the universe of all remotes. Keep in mind that we can
>> take either a configured remote or a URL (or ssh host). So what does:
>>
>>   git push foo:bar
>>
>> mean? Is it pushing "refs/heads/foo" to "refs/heads/bar" on "origin"? Or
>> is it using the default refspecs to push to the "bar" repo on the host
>> "foo" over ssh?
>>
>> So you would need some heuristics based on whether something was a valid
>> refspec, or could be a valid remote name or URL.
>
> Assume that we agree on what remote is implied, we could simplify
> parsing by specifying the remote with "." (or something short and
> unambiguous). So the above command would become
>
> git push . foo:bar

A URL may be a path to a git repository, and '.' is a valid path.
Currently, 'git push .' seems to push to the current repository (what
does that even mean?).  For something truly unambiguous, we'll have to
use a character that's disallowed in URLs and isn't interpreted by the
shell- I can't seem to think of one.  Otherwise, we'll have to
fallback to using heuristics anyway.
