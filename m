From: Bill Okara <billokara@gmail.com>
Subject: Re: git mv messed up file mapping if folders contain identical files
Date: Wed, 24 Feb 2016 16:51:43 -0700
Message-ID: <CADsr5c8akqt7tsgptuDqCyt2JW8ie9js5eFt7oxXxDxtGMLJFA@mail.gmail.com>
References: <CADsr5c_Hk34KBN06dM9Hk5HPW9-Mt3eZLMgvyes8sSgxCA-k0w@mail.gmail.com>
	<xmqqwpptr83a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 00:51:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYjDj-0007HB-5k
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756385AbcBXXvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:51:45 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33476 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438AbcBXXvo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 18:51:44 -0500
Received: by mail-ob0-f169.google.com with SMTP id jq7so33624906obb.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 15:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=laffgENMNVnR2dJZ7LocFYWqSwYVdlmYPfJIPvEqv/8=;
        b=cS6wVwZZggBPObYXncR6E0za6kMEFGbql+J7UZNRh/0X+DqdB4NQ/0wgBw7Yn+Fg9w
         sC3WZFrvE+2MaaKVb5/hHAONhZPXITwYrE3ILpmQX2rL8DDm2xkyIRI/9oll8F1of99g
         UCiQMJUsbt9c8ZeNVXFUpEin8+Lw0yUCfqWmCXztCDYRIuwBHMaQxtuQ+Iv/GVXXDx4P
         Zo8wErIDhBg20rEaYMKiAnKF/RaamnpN4nJ6eMVot6NpBFCIHY0S/hI9yzMYqRhC9bDD
         ZEuI+VtaSuDxNzr7HXotFX/C9yh8eIz/VZQ96CRtAswhqdtdCWlHlG2CJ23SKi8J+Z26
         sVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=laffgENMNVnR2dJZ7LocFYWqSwYVdlmYPfJIPvEqv/8=;
        b=aR5kJgBgHMR2wvXaLzZMqf/syc63Na5wyXViUcRcJSMbYdahdViRrl436/tx+AFspQ
         RUbjNZCdb5amNIv9O+ntUXI9V6vn3zHmTCi469AAyzZYzklcbz1rCzLyhMJlAgncdmBt
         7Jf39U2QPJqZGIj53Tz4kQ9xRkJP3NvtJIP/+XjafrlsDwcGou/4OB19ZCbbrsvijS3B
         LqGWPBW/hUoOaiDz78JPtXMt3XrexgloK+UDyXcYuf15njfpVX/TET1ky33/VmDpUnQx
         /IaMjOEidH8EEQnAQgBUVQEXu9FKbrx+uHZYynIE9rGdHVJAIhW7rNbyCZ+gC38+fl7Z
         GNZA==
X-Gm-Message-State: AG10YOTpWF/fYh3o6zsHSkmvLHFBH4CLQnCkfDwa9VsoE9UvH0CyV8vf8KK667/IZoOem2tuutgU0t6gK6hBTQ==
X-Received: by 10.60.144.9 with SMTP id si9mr36112709oeb.81.1456357903809;
 Wed, 24 Feb 2016 15:51:43 -0800 (PST)
Received: by 10.182.17.103 with HTTP; Wed, 24 Feb 2016 15:51:43 -0800 (PST)
In-Reply-To: <xmqqwpptr83a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287285>

it actually does matter in the following scenario:

1) master branch has identical content.txt files in the folder structure
2) do the git mv in a new branch
3) master branch updated the context.txt to contain new data (more
relevant to the containing folder)
4) new branch need to merge the updates from master

after the merge, demo/content.txt in the new path would contain
updates from dev/content.txt from master...

On Wed, Feb 24, 2016 at 4:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Bill Okara <billokara@gmail.com> writes:
>
>> just want to see if this is a bug, user error (on my end), or??
>
> Not a bug, not a user error, just "it does not matter", I think.
>
>
