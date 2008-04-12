From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 2/3] builtin-status: submodule summary support
Date: Sat, 12 Apr 2008 22:47:25 +0800
Message-ID: <46dff0320804120747j424d459oc0987beb27fce1c6@mail.gmail.com>
References: <1207841727-7840-1-git-send-email-pkufranky@gmail.com>
	 <1207841727-7840-2-git-send-email-pkufranky@gmail.com>
	 <1207841727-7840-3-git-send-email-pkufranky@gmail.com>
	 <7vtzi8owf9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Johannes Sixt" <johannes.sixt@telecom.at>
To: "Junio C Hamano" <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 16:48:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkh1Y-0006LV-OH
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 16:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbYDLOr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 10:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbYDLOr2
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 10:47:28 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:32813 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbYDLOr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 10:47:27 -0400
Received: by an-out-0708.google.com with SMTP id d31so221305and.103
        for <git@vger.kernel.org>; Sat, 12 Apr 2008 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=J7PQqHjo/w3/z+rXGpg4t0U3aBf4rADN/UILyh6GOOI=;
        b=obQ1ZzTNmE9lzTEUuyWfPRqBM5k7ebjPZlpcT1kKwsEth95Pkas7OsjJJzbT6c/mY8DV0l4nskI6oVbOe8TKUiVGqXJEaB4mWMyZdZB0FvQaPXq63kCeW2YczshQ2A/G2r5U6oFFf5Zxj4kaY8y23qFH3vc5evSMoXAoflhoJ4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t13g9c3bpL1h4VeamBE0J//VbhPnNqb/S3Jbt7ojx42W3piEiMKRYkrr9renB7B5cX4jkcihZSoa3DghenTBaQiAaOMi/kPOiHP/CyzXe1RkMXHMOp8L3mFYDUDs/XpXd9Kb/ch2V1xdvNy7orvuQMRIAokfIlt6quGKfOmFYOY=
Received: by 10.100.41.4 with SMTP id o4mr1307678ano.136.1208011645603;
        Sat, 12 Apr 2008 07:47:25 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sat, 12 Apr 2008 07:47:25 -0700 (PDT)
In-Reply-To: <7vtzi8owf9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79355>

On Sat, Apr 12, 2008 at 6:31 AM, Junio C Hamano <junio@pobox.com> wrote:
>  > +static void wt_status_print_submodule_summary(struct wt_status *s)
>  > +{
>  > ...
>
> > +     memset(&sm_summary, 0, sizeof(sm_summary));
>  > +     sm_summary.argv = argv;
>  > +     sm_summary.env = env;
>  > +     sm_summary.git_cmd = 1;
>  > +     sm_summary.no_stdin = 1;
>  > +     fflush(s->fp);
>  > +     sm_summary.out = dup(fileno(s->fp));    /* run_command closes it */
>  > +     run_command(&sm_summary);
>
>  I recall we had some clean-up on how file descriptors are inherited and
>  duped around when run_command() runs a subprocess.  Hannes, is this dup()
>  consistent with how the things ought to be these days?

I think dup is needed, as commit c20181e3a3 says, run_command still
will close passed in positive descripors.

    start_command(), if .in/.out > 0, closes file descriptors, not the callers

    Callers of start_command() can set the members .in and .out of struct
    child_process to a value > 0 to specify that this descriptor is used as
    the stdin or stdout of the child process.

    Previously, if start_command() was successful, this descriptor was closed
    upon return. Here we now make sure that the descriptor is also closed in
    case of failures. All callers are updated not to close the file descriptor
    themselves after start_command() was called.


-- 
Ping Yin
