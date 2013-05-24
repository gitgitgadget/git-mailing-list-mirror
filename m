From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] sha1_name: implement finding @{push}
Date: Fri, 24 May 2013 21:45:52 +0530
Message-ID: <CALkWK0=XufbcwObBq7_MWX3jL63Nv3YeSvTUpOfXD+XoKkvMag@mail.gmail.com>
References: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
 <1369321970-7759-8-git-send-email-artagnon@gmail.com> <CACsJy8CV192WVW8u6YRnbf6Ue6tFbzyiCARwicwzapSZucaaMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 18:16:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfufW-0004jK-BY
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 18:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322Ab3EXQQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 12:16:34 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:60860 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721Ab3EXQQd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 12:16:33 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so13033405iet.28
        for <git@vger.kernel.org>; Fri, 24 May 2013 09:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iGrmN7WKhecTSW5wtKAQluwgK9ruzj+46IRLVS4WHCY=;
        b=qxKoJdDhhfVciIeQNcb9KNA/hYvpPKxXzmZjk+KzfoUVgppCxtPjkHHKlH91RijMor
         l9SULBlNd847YwkTyl+uB1xoWZYKBmzYudOv8IE/fZZH8+/FuCTyQ8NPOBCBB9QEYeBu
         8AvhPJzq5R50D+99tEhhl/bgu+3qMsX4sOR9bim4LCuwdlsJPO9BGI3m4Gx45WvrSGla
         Lv2IYTsATIYZxpKP8bn9jdqD02r9wpoqXgfyZmDqDU79THj4z7Li8WpLfMS3uuCt2ART
         AKUsSOkHFZGuafwM5RdoyrikaU1uCNauktOUkE/vhVTd6VFqWFSqV9nDFfpZAnT5ahn2
         2ilA==
X-Received: by 10.50.11.72 with SMTP id o8mr2773192igb.44.1369412193460; Fri,
 24 May 2013 09:16:33 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 24 May 2013 09:15:52 -0700 (PDT)
In-Reply-To: <CACsJy8CV192WVW8u6YRnbf6Ue6tFbzyiCARwicwzapSZucaaMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225372>

Duy Nguyen wrote:
> On Thu, May 23, 2013 at 10:12 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Try this now: configure your current branch's pushremote to push to
>> "refs/heads/*:refs/heads/rr/*".  Now, type 'git show @{p}'.  Voila!
>
> Voila what? Why not avoid guessing game and describe what the patch is for?

If you're on branch master, it'll output refs/heads/rr/master.  The
topic is about having a @{push} corresponding to @{upstream}

>> +static void find_push_ref(struct branch *branch) {
>> +       struct remote *remote = pushremote_get(NULL);
>> +       const struct refspec *pat = NULL;
>> +       char raw_ref[PATH_MAX];
>> +       struct ref *this_ref;
>> +       char *dst_name;
>> +       int len;
>> +
>> +       sprintf(raw_ref, "refs/heads/%s", branch->name);
>> +       len = strlen(raw_ref) + 1;
>> +       this_ref = xcalloc(1, sizeof(*this_ref) + len);
>> +       memcpy(this_ref->name, raw_ref, len);
>> +
>> +       dst_name = get_ref_match(remote->push, remote->push_refspec_nr,
>> +                               this_ref, MATCH_REFS_ALL, 0, &pat);
>> +       printf("dst_name = %s\n", dst_name);
>> +}
>> +
>
> Isn't this an abuse of extended sha-1 syntax? How can I combine this
> with other @{}, ^, ~...?

I'm unsure what you mean.  How can I be on branch master^1?  Did you
read the cover-letter?
