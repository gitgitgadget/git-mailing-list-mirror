From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sun, 9 Jun 2013 12:13:41 -0500
Message-ID: <CAMP44s1PENiKMy03_mgZ_myiGP5+qpaE2bvo0LN3X3mZhSvT2g@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
	<CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
	<CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
	<20130609151235.GA22905@serenity.lan>
	<CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
	<20130609160225.GB22905@serenity.lan>
	<CAMP44s0Zsejk4Ex6QfzOFOom3cyWv_hziWGkAK-LawSUkT9V3Q@mail.gmail.com>
	<20130609164248.GD22905@serenity.lan>
	<CALkWK0k=39-Cq3vNdrpLPTWa0wgkqLM=7c=cAmL0nvx0MT5mkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:13:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljBb-0000eD-KA
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023Ab3FIRNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:13:43 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:51359 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab3FIRNn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:13:43 -0400
Received: by mail-lb0-f178.google.com with SMTP id y6so4140221lbh.37
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GsFtZS/NyTOesw1wgKxsdhTU3HYIGmJ9uf2gZRIcGts=;
        b=SiVWyFvI271NbceVxQFr8jetxfiPbvVDTEWaWd2fKRWRCxy2YbCZsmoswfYplqyYkw
         GgIbTW9HFB/H6s0YWnVci1iZyEo3nm3b9sSw7EKFjmqAoAs5TzY9WpvVtnJATuRTLx3p
         vUpB5DRb0O3OwQ/JJ3VZcMZ1nIGCtLRmDrCDQO4j5pfdHWRhutNru7jcL9ZGk4gbf325
         8nNOtO1/tzHps0ZKquGaFZELgxQQ/K02qpBdXbEm+RI60Q2R7m/u///7wSshs5RnpWnS
         V+BoM+kaG64AlCDs5fMoK3/ptR9StAPmXJz3MteWs+kXazXKfolfy1P5g7GQ4mDDmG1x
         Li/g==
X-Received: by 10.112.166.67 with SMTP id ze3mr4986931lbb.25.1370798021515;
 Sun, 09 Jun 2013 10:13:41 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 10:13:41 -0700 (PDT)
In-Reply-To: <CALkWK0k=39-Cq3vNdrpLPTWa0wgkqLM=7c=cAmL0nvx0MT5mkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227026>

On Sun, Jun 9, 2013 at 12:03 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> John Keeping wrote:
>> Calling across from one builtin/*.c file to another is just as wrong as
>> calling into a builtin/*.c file from a top-level file but the build
>> system happens not to enforce the former.
>
> So libgit.a is a collection of everything that is shared between
> builtins?  Does that correspond to reality?
>
>   $ ls *.h | sed 's/.h$/.c/' | xargs file
>
> An example violation: builtin/log.c uses functions defined in
> builtin/shortlog.c.
>
> What is the point of all this separation, if no external scripts are
> ever going to use libgit.a?

And all the functions should be static, which doesn't seem to be the case:

00000000000003c0 T add_files_to_cache
0000000000000530 T interactive_add
0000000000000410 T run_add_interactive
0000000000001920 T textconv_object
00000000000005b0 T fmt_merge_msg
0000000000000090 T fmt_merge_msg_config
0000000000000c00 T init_db
0000000000000b40 T set_git_dir_init
0000000000000360 T overlay_tree_on_cache
0000000000000500 T report_path_error
00000000000011a0 T copy_note_for_rewrite
0000000000001210 T finish_copy_notes_for_rewrite
0000000000001060 T init_copy_notes_for_rewrite
0000000000000000 T prune_packed_objects
0000000000000510 T shortlog_add_commit
00000000000006b0 T shortlog_init
0000000000000780 T shortlog_output
0000000000000000 T stripspace

-- 
Felipe Contreras
