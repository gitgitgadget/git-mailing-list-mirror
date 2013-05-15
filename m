From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: is this a bug of git-diff?
Date: Wed, 15 May 2013 09:10:11 +0200
Message-ID: <CALWbr2z2jB53=2UsEneqymU2peiL4OW9Tyace_8BN3=1gA9jNg@mail.gmail.com>
References: <CABwUO_X8oTzuJh8+v3Oqca2W4ht-cQRNGQ+a1DbEruq5jY+vgA@mail.gmail.com>
	<CALWbr2z338CJgavC9sVGffHSoqr0Sb9nCsr4LKURDYpkOog2TQ@mail.gmail.com>
	<CABwUO_Wyq34S=CwbLeAqmzaFLxORkvGEvrjUzMXjkJdE1jnbhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: eric liou <accwuya@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 09:17:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcVxo-0002PK-6l
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 09:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960Ab3EOHRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 03:17:24 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:56367 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab3EOHRX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 03:17:23 -0400
Received: by mail-qc0-f169.google.com with SMTP id z10so232131qcx.0
        for <git@vger.kernel.org>; Wed, 15 May 2013 00:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=5kZ525rLhg/fLN8RYhCblCdU7kkdYVeJdMhKbEQ4j+s=;
        b=rswU/vYl5vOkxyiJjAJQvYSPeMP5go5N6b1x49KVzAgvokAikFx6DDp6QxiDTBn3xd
         fCIqGNxSh7fW/zBXWyNxpnr5vgvQSy3Dv9TXATecAoSBzOkUezl9E5D6lYG5ee8tUnk3
         UTayED0KbSrIJWyOZA0bJfh8NDQfxiFtDeDjdgq4O3Soi5ybD/aqnvIwoY5U0QrI7Pc7
         b7NN1UQ5DhBX5rwVZnEvTawgRZ3/v/BkzxRgh8rNmDV7rbHX+J4A0Nk9WGazxB8GqfB/
         RM/V5oK6MZwdVZ7618JizVzS45rq7mHOMAuYFQ2v0TzInXk8kSPlLWlWt6x93VT2Caxd
         mCtg==
X-Received: by 10.49.58.1 with SMTP id m1mr15673241qeq.40.1368601811383; Wed,
 15 May 2013 00:10:11 -0700 (PDT)
Received: by 10.49.81.99 with HTTP; Wed, 15 May 2013 00:10:11 -0700 (PDT)
In-Reply-To: <CABwUO_Wyq34S=CwbLeAqmzaFLxORkvGEvrjUzMXjkJdE1jnbhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224389>

On Wed, May 15, 2013 at 8:52 AM, eric liou <accwuya@gmail.com> wrote:
> Thank you for the quick reply.
> But this line is not correct: "@@ -4,5 +4,6 @@ int a = 1;"

Oh OK, I see.
Git tries to name the function where the changes take place. This is
purely informative.
In your example, you don't have any function so of course the
information is not very helpful.

Typically it will look like the following, helping the reader by
giving the function name:

@@ -591,6 +609,14 @@ int cmd_grep(int argc, const char **argv, const
char *prefix)
                paths[1] = NULL;
        }

+       if (!use_index) {
+               if (cached)
+                       die("--cached cannot be used with --no-index.");
+               if (list.nr)
+                       die("--no-index cannot be used with revs.");
+               return !grep_directory(&opt, paths);
+       }
+
        if (!list.nr) {
                if (!cached)
                        setup_work_tree();
