From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: Work around freeze problem with dialogs in Mac
 OS X
Date: Wed, 22 Sep 2010 12:01:10 -0700
Message-ID: <7vocbpsivd.fsf@alter.siamese.dyndns.org>
References: <1jogy2y.tfhl6g1eq9mylM%lists@haller-berlin.de>
 <1jp8k4n.1lz3bce9u857kM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Wed Sep 22 21:01:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyUZM-0007oR-7m
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 21:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090Ab0IVTBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 15:01:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071Ab0IVTBT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 15:01:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AC1FCD8EFD;
	Wed, 22 Sep 2010 15:01:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oTdrDjYHYN7CFEppfKwZ4aRROSk=; b=jzlohd
	aKH7pr1UaSDiofC9GyTU5zSWvJ6rXaDhl3MOaZv4ynwutI7wm86ax1I95xnn0IJt
	MPIusS8s9BRxgm3dsinprk6hVxfd8ZHoXy6lwHsDpYFayJDHvjMWTAOUcrTENnNV
	SwhN1CfpgQHwrAMCC0bJucfcGY3kdESyvO6AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pbkn3p4hZmF1rX9fNsMFr13z26dDo1fe
	69+H46CrH/95h0Z6rt0c1nM/iqoJ+sK639OACjLzYUfMT5S5g4+bER2G+5Ycp0v/
	cfaXHKtw2LQbZA+2W3ZO3xM6ViLl0L5YWZCXcLix7hRjFSIbLG7YnOz8Kvqbfr00
	u0niSLjwddg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 135E4D8EFB;
	Wed, 22 Sep 2010 15:01:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CC3ED8EF9; Wed, 22 Sep
 2010 15:01:11 -0400 (EDT)
In-Reply-To: <1jp8k4n.1lz3bce9u857kM%lists@haller-berlin.de> (Stefan Haller's
 message of "Wed\, 22 Sep 2010 19\:46\:52 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C60DF1F8-C67B-11DF-9F98-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156825>

lists@haller-berlin.de (Stefan Haller) writes:

> Tk 8.5 on Mac OS X has a bug whereby a dialog opened from a key
> binding will hang; see issue 3044863 in the Tk issue tracker.
> <http://sourceforge.net/tracker/?func=detail&aid=3044863&group_id=12997&atid=112997>
>
> To work around this, we perform commands that open a dialog after
> a brief delay; 150 ms seems to be a good compromise between short
> enough as to be not annoying, and long enough to reliably work
> around the issue.
>
> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>

Is 150ms applicable no matter how fast or slow your Mac is, or is Mac so
monoculture that everybody's machine has more or less the same performance
characteristics?  IOW does this need to be autoadjusted?

I see a lot of wrapping around foo::dialog; without knowing much about
Tcl, I wonder if it would be simpler, less error prone and more future
proof to add the wrapping logic around something commonly used from them,
e.g. class::make_dialog.

> ---
> I already sent this two days ago, but it didn't seem to appear on the
> list for some reason, so I'm resending it. Apologies if you see this
> twice.
>
>  git-gui.sh |   39 +++++++++++++++++++++++++++------------
>  1 files changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 4617f29..394c2a0 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -3560,6 +3560,21 @@ if {[info exists repo_config(gui.wmstate)]} {
>     catch {wm state . $repo_config(gui.wmstate)}
>  }
>  
> +proc mac_freeze_workaround {cmd} {
> +   if {[is_MacOSX] && $::have_tk85} {
> +       # Tk 8.5 on Mac OS X has a bug whereby a dialog opened from a key
> +       # binding will hang; see issue 3044863 in the Tk issue tracker.
> +       # <http://sourceforge.net/tracker/?func=detail&aid=3044863&group_id=12997&atid=112997>
> +       #
> +       # To work around this, we perform commands that open a dialog after a brief
> +       # delay; 150 ms seems to be a good compromise between short enough as to be
> +       # not annoying, and long enough to reliably work around the issue.
> +       after 150 $cmd
> +   } else {
> +       $cmd
> +   }
> +}
> +
>  # -- Key Bindings
>  #
>  bind $ui_comm <$M1B-Key-Return> {do_commit;break}
> @@ -3567,8 +3582,8 @@ bind $ui_comm <$M1B-Key-t> {do_add_selection;break}
>  bind $ui_comm <$M1B-Key-T> {do_add_selection;break}
>  bind $ui_comm <$M1B-Key-u> {do_unstage_selection;break}
>  bind $ui_comm <$M1B-Key-U> {do_unstage_selection;break}
> -bind $ui_comm <$M1B-Key-j> {do_revert_selection;break}
> -bind $ui_comm <$M1B-Key-J> {do_revert_selection;break}
> +bind $ui_comm <$M1B-Key-j> {mac_freeze_workaround do_revert_selection;break}
> +bind $ui_comm <$M1B-Key-J> {mac_freeze_workaround do_revert_selection;break}
>  bind $ui_comm <$M1B-Key-i> {do_add_all;break}
>  bind $ui_comm <$M1B-Key-I> {do_add_all;break}
>  bind $ui_comm <$M1B-Key-x> {tk_textCut %W;break}
> @@ -3606,16 +3621,16 @@ bind $ui_diff <Control-Key-f> {catch {%W yview scroll  1 pages};break}
>  bind $ui_diff <Button-1>   {focus %W}
>  
>  if {[is_enabled branch]} {
> -   bind . <$M1B-Key-n> branch_create::dialog
> -   bind . <$M1B-Key-N> branch_create::dialog
> -   bind . <$M1B-Key-o> branch_checkout::dialog
> -   bind . <$M1B-Key-O> branch_checkout::dialog
> -   bind . <$M1B-Key-m> merge::dialog
> -   bind . <$M1B-Key-M> merge::dialog
> +   bind . <$M1B-Key-n> {mac_freeze_workaround branch_create::dialog}
> +   bind . <$M1B-Key-N> {mac_freeze_workaround branch_create::dialog}
> +   bind . <$M1B-Key-o> {mac_freeze_workaround branch_checkout::dialog}
> +   bind . <$M1B-Key-O> {mac_freeze_workaround branch_checkout::dialog}
> +   bind . <$M1B-Key-m> {mac_freeze_workaround merge::dialog}
> +   bind . <$M1B-Key-M> {mac_freeze_workaround merge::dialog}
>  }
>  if {[is_enabled transport]} {
> -   bind . <$M1B-Key-p> do_push_anywhere
> -   bind . <$M1B-Key-P> do_push_anywhere
> +   bind . <$M1B-Key-p> {mac_freeze_workaround do_push_anywhere}
> +   bind . <$M1B-Key-P> {mac_freeze_workaround do_push_anywhere}
>  }
>  
>  bind .   <Key-F5>     ui_do_rescan
> @@ -3625,8 +3640,8 @@ bind .   <$M1B-Key-s> do_signoff
>  bind .   <$M1B-Key-S> do_signoff
>  bind .   <$M1B-Key-t> do_add_selection
>  bind .   <$M1B-Key-T> do_add_selection
> -bind .   <$M1B-Key-j> do_revert_selection
> -bind .   <$M1B-Key-J> do_revert_selection
> +bind .   <$M1B-Key-j> {mac_freeze_workaround do_revert_selection}
> +bind .   <$M1B-Key-J> {mac_freeze_workaround do_revert_selection}
>  bind .   <$M1B-Key-i> do_add_all
>  bind .   <$M1B-Key-I> do_add_all
>  bind .   <$M1B-Key-minus> {show_less_context;break}
> -- 
> 1.7.3.4.g200b9
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
