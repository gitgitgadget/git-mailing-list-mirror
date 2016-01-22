From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/7] merge: add --rename-notes
Date: Fri, 22 Jan 2016 10:35:56 +0700
Message-ID: <CACsJy8D3-i4UpavWZz0QU6oJE3AK06ugjPPTMOtqUA+Sa7==qQ@mail.gmail.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
 <1453287968-26000-8-git-send-email-pclouds@gmail.com> <xmqqtwm6yg30.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 04:36:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMSWW-0000Rw-KP
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 04:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbcAVDg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 22:36:29 -0500
Received: from mail-lb0-f196.google.com ([209.85.217.196]:34417 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbcAVDg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 22:36:27 -0500
Received: by mail-lb0-f196.google.com with SMTP id oe3so2952146lbb.1
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 19:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jklo46lVvRqcwOFfwT95HCRXovMXYBhzeluK5mrmku8=;
        b=Ud3m+TEBSaYXBgF9Hd1dUbxNlelpe/ngpDqyidEbuPz07l7CfzHCy5ftB97bg9uR/N
         gdHIBhfmlb0GZpbqbEC7INVxM+ojLMi4qqMSqeaTUNTXpeLKuGUraCAp889NkulPcC0H
         hrAdjW8ujnSjlDgzTeYKAbdxRH+fmVvflBhYQJy2gCe9ofzLA0vkU91i6HOtBF54/R/G
         RI98eo5WfWhxipdVMwyylm5plPJY08S3Gf41NV4fIAvrQx/tRZ/g6pnsfLZcAm1Wbpm3
         fy+D2cEKinnQddIfxwLjUuvOno22MOw+fTIBJ696hHA+6E3wN5o2Fu7lKLldlx1t+ukt
         AX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=jklo46lVvRqcwOFfwT95HCRXovMXYBhzeluK5mrmku8=;
        b=WaKCb5h8f1kUAMgXgMfWyHWphvIiXv+ni6z9cpRGURhmPHQUBhp5+UXV9w3wEcsJ+g
         q87dewXPgxUQcx28kt0fMfiux1lAa9CDIQUiIidpEo/A4TQtqqvm6EPspMDF7TeIwA7G
         Qk9r6Ec6ldcyRwFxO5feEG6vKbXHFrZKccIisKMx7Fm93o79VJaBLfg83uvaorQc737+
         PYXHKgCo3z/jmdPAWQuPpl7gwiOLzvR+QB7NoyY0YLeIIjQofFDE+r/PHrtaWaODAVQI
         sx6sYqMk6wh2bkSQvTU1ejxZ4LvO0VB91Doqs92vovG2iMQ5hpsHmS96QTLjADWafU0H
         8ahQ==
X-Gm-Message-State: AG10YOTYmc0gzCv/C4puLsbo+E42H+HntwDLr/UhT+8whtIi9BM7nrkbILSlyQBeOQKK1ZBGvb8sHFw0LutP1Q==
X-Received: by 10.112.149.230 with SMTP id ud6mr300266lbb.12.1453433786382;
 Thu, 21 Jan 2016 19:36:26 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 21 Jan 2016 19:35:56 -0800 (PST)
In-Reply-To: <xmqqtwm6yg30.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284546>

On Fri, Jan 22, 2016 at 12:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> This uses _all_ merge notes attached to _any_ commit in the history,
> without even checking if the commit is involved in the current merge
> being done?  How would that be useful?
>
> I also suspect that the data structure to keep track renames by
> using notes needs a better design.  You seem to have a note per
> commit and one note records a set of "this goes to that", and
> that is the reason why you need to discriminately read everything
> under the sun.
>
> I think the index into the notes tree for the purpose of this use
> case should not be "which commit records this set of renames?",
> but by "what is the destination blob of possible rename
> operations?".  IOW, if a path that held blob X was moved to
> another path that holds blob Z in commit A, and if a path that
> held blob Y was moved to another path that holds blob Z in commit
> B, attach a note to blob Z that records "moved from X in A" and
> "moved from Y in B".

This is exactly the output after merge_rename_notes() is done. A
bunch of "rename this blob to that blob" pairs.

The problem with indexing notes tree by blob is how the user will
manage it. From the user perspective, I think it's natural to
think "I have made this commit that renames this path to that
path. But Git does not recognize it. I need to correct it by
adding a note to the commit".

The notes tree saves exactly that. Reading and updating can be
done with existing tools. Exchanging git notes is something we
have been avoiding looking at, but per-commit notes would make it
easier to exchange too, I think.

The information in that form may not be the best way to be
consumed by Git. But that is what cache is for. We can either
generate a secondary notes tree, indexed by blob, or naively a
big "blob to blob" rename file that I did in this patch. But it
does not have to be visible to the user.

If notes-indexed-by-blob is exposed to the user, I think we need some
more helper tools to edit and view them because blob SHA-1 is not
something the user deals with, normally. It feels not as easy as
editing a simple text file, to me.
-- 
Duy
