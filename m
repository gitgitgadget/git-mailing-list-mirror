From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] reachable.c: mark reachable objects in index from all worktrees
Date: Thu, 2 Jun 2016 16:37:06 +0700
Message-ID: <CACsJy8CsmeRgk49quPZe5vx5W_3X1T=ConhsfPBEcEwvJ1-b4Q@mail.gmail.com>
References: <574D382A.8030809@kdbg.org> <20160601104519.16563-1-pclouds@gmail.com>
 <20160601104519.16563-3-pclouds@gmail.com> <1464807435.3988.9.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 11:37:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8P4P-0007cm-Do
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 11:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbcFBJhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 05:37:37 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:35579 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080AbcFBJhg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 05:37:36 -0400
Received: by mail-it0-f51.google.com with SMTP id z189so105944924itg.0
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VE9zpBIgwssrUegT2gCuexoSytykbbW3JsPydfO3Ea0=;
        b=rJxZuviNxy+h7KKEohO1rXkaqZId0vOHAInkFAlch4dHI/29UNrfoQfPNYQ6/8Xl7p
         O4SwSgXAqgL/YCivdKMfbqDGjj5jb1I+Y5TAXE1o8Vx+BDNXALPFjWNVp8v251jmBJAV
         0pbc148+hsG1Y0/e+v2T1s91nLNST1zLj0hWNwNEzqWib1/HlLsmPVKDHGZVLLsfMNaY
         6H9EdRCrt5e06kRSbkbaHbIhaMxrfWIsH9t/ajB3jtU/FdF37zf1PYXyPj0aiYkApEft
         G+frzncE45qWMBEX6+5ENNF6dYxF5nzu5NliM+pl9D+8TROu/LoqYXo0J2ZXG2UHM33d
         UqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VE9zpBIgwssrUegT2gCuexoSytykbbW3JsPydfO3Ea0=;
        b=mcaRJkqtHtY59DHxDZGi9Mi3/rIRtmI9Bo5lyXblIrLNBHRlOqv7PO7gpg3WVD1bV4
         tX5JlzL91RLDv90P2z046IEOA4xRrgUaP0eO/ag8ZqRSMoNACZmBZmwHIsRl7sZAPTHJ
         n9uwlu2xmaOk9G6wNnIjxSJAL6A46UCJFotKnsfKZRfzaeZuOVjARQAXHhmqA+YBMMGB
         Do8FEBRjMzHfpCicAwHyaSTCOjwijU3Kf9WSwqVPD8t53uNxrE1np3hj83Lv1gh1Z5Gp
         jas1/t3VCQnMCzLLGEtZwxA8dYp49NLu4cWCY9owOwtbGKMwtfKXHrzlp79DIg5ERqmg
         qVaw==
X-Gm-Message-State: ALyK8tIAyRnifkxNVmenBnAFZWvO0aIeCZYBnZEm4TSokBCjK9UzjLi7IvI2v3+dzYm/kK6QSeb6+yFVk0mexA==
X-Received: by 10.36.115.76 with SMTP id y73mr2371906itb.63.1464860255779;
 Thu, 02 Jun 2016 02:37:35 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Thu, 2 Jun 2016 02:37:06 -0700 (PDT)
In-Reply-To: <1464807435.3988.9.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296190>

On Thu, Jun 2, 2016 at 1:57 AM, David Turner <dturner@twopensource.com> wrote:
>> +             struct index_state istate;
>> +
>> +             memset(&istate, 0, sizeof(istate));
>
>
> Why not just struct index_state istate = {0}; ?
>

My first thought was.. "hmm.. C99?" but then there are 24 of them in
the code base already. Will change.
-- 
Duy
