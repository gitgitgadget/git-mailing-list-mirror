From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git gc and worktrees
Date: Tue, 31 May 2016 19:02:15 +0700
Message-ID: <CACsJy8BHU0YtgvjuefRPuMPLhvoOPLVMhR4YzH8=wVFeOie+Xw@mail.gmail.com>
References: <574D382A.8030809@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue May 31 14:03:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7iNx-0000rk-6X
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 14:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbcEaMC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 08:02:57 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:32931 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbcEaMCp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 08:02:45 -0400
Received: by mail-io0-f169.google.com with SMTP id t40so131230647ioi.0
        for <git@vger.kernel.org>; Tue, 31 May 2016 05:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BT8+y9P+yxBD3aEu0k5B/TG1YT3limc7xyN23J7kX70=;
        b=QnRneE2uiIiH1FHpTPQx2CFw1WMpXo+kVCL5/nWBbxOBQBpJvFp2O4g3X3JnyNNsOa
         rf64dJjjZY8BnrzdSmhzDeslG/x8dBNwmkIjLoDD1ENwA5aZOUdagC6S0QSfFDDN7eZj
         v6c7f0A00CfC+TFnlt7wLWgo7fC3rnQjZ0/+euCaa4pFtGV+INXBxmp2vnoaiRp8Qown
         /Tr22T5XcF2g0qdz0W7gga8DWfsjQGzXqUhg5HOSBzjay3SFF7opvkx4vB+fFEmN/phl
         1XJOGgjfwvyu61+X8EWF0LReaMOAjw/i4Q2l1PRAKuGwsZUoBOeG7WAzRQcALcbIgeqe
         LDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BT8+y9P+yxBD3aEu0k5B/TG1YT3limc7xyN23J7kX70=;
        b=KMDHmepGJQQv1uH9QcybBaXthZZdFEWTaJyJphUdC/x1sGMSghvAFhBQN/yUzGxwW6
         RKNlFzAPrPl3smsDyNySh/WfDOnZhbnl5Ai10WrATO8f1S1kZPwfyxHILXxhMzQkEBaq
         4m9LgQO4DblfKlBw8rSP/nZOHDa4oZG+UY1Bj5bLDjB0jImSLOGDIw8MFx318ILMvBrm
         ncVeCgxfLjolUqWjc9tAqfXEap8+jU7KNOtXXyc86fNCR3eLY6cFEjufcJ+dgFbJ+ITh
         p3e0L/0PoXdKX2beelQeS7SYnn0FLAaKgOnWaVc2iwIaj5qQKEtuYmzUCbed7aRLnFoJ
         +Dlw==
X-Gm-Message-State: ALyK8tKKXUyD/Z8VhnaKgnCdpk/4Pl0qCNTP/sIy+Um5Nz+OxQSbTpZTlzcIjHyUMO07lmUqcuBPqet7NrfF4g==
X-Received: by 10.107.8.142 with SMTP id h14mr27411353ioi.95.1464696164774;
 Tue, 31 May 2016 05:02:44 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Tue, 31 May 2016 05:02:15 -0700 (PDT)
In-Reply-To: <574D382A.8030809@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295970>

On Tue, May 31, 2016 at 2:07 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Earlier this year I had a largish merge going on in a separate worktree.
> With a mix of staged resolutions and unmerged paths in the index, I ran 'git
> gc' in the main worktree. This removed a lot of objects that were recorded
> in that separate worktree index. (I was able to recover them because the
> content was still on disk.)
>
> Now I wanted to derive a test case that shows that breakage, but I am unable
> to. The objects recorded in a separate worktree index, but not committed,
> yet, are not pruned anymore.
>
> Have there been any fixes in this regard recently? Or does this look like
> something else going on?

Not sure. I vaguely recall Jeff touched this pruning issue once,
something about recent objects will not be pruned based on mtime. But
maybe some of those objects in the index are not so young, and because
I think we never check indexes in git-gc/git-prune, they have a chance
to be deleted.

No I'm wrong. mark_reachable_objects() which is used by git-prune,
does add objects from index and HEAD, which only covers those from
_current_ worktree. This should be fixed even if it is not the root
cause of your problem. I'll look into it.
-- 
Duy
