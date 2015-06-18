From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/WIP v3 04/31] am: implement patch queue mechanism
Date: Thu, 18 Jun 2015 10:47:19 -0700
Message-ID: <CAGZ79kbdUhH9=Xui6jeco-H6ZGaiC5jtLdBp9K7xv7AnsmmeKQ@mail.gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-5-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 19:47:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5duc-0006zQ-8l
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 19:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914AbbFRRr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 13:47:27 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36125 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbbFRRrU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 13:47:20 -0400
Received: by ykdr198 with SMTP id r198so72645970ykd.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ItBHRN6ffkkSig4xES3Nm8J3nlaWMM1+tUeu4txmM2E=;
        b=Fx1Y4DZO0+wgUDSZ36oPBCVPMRmfOQCcRbPqulQv2+WXeHwI0ErzakvIhmR4RlZZOX
         I7QdHvN4bpc6cP5E2tD7IP57aFIbfvSN2pf8WpE950EzaSV+dBM76NT8GFgMXl97hTvW
         dokgFUctvLeRNtxJZI00xeKLoDYTgGxHzflPRCE/K7+PGAjI+E2NFt1WOOV/52lTuJQt
         PX6O+cyOpRvpAkTh3AyfWuOqgZ1wqcLeYbXwGZXo07BPcRUGw9k2tWvOVOSV9QsdGPCQ
         1uMhN1PJ/feMnRZ8cO1tVRj0gUuUvSQsXMeXIwg7P23hnUNMc1suXUTRlAXzRCEnRlMC
         uVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ItBHRN6ffkkSig4xES3Nm8J3nlaWMM1+tUeu4txmM2E=;
        b=BXsMdDPr0+fu6RszJQQw1YsRH5ZjDAycqpWTaFSXFLqZrT+MERXa5qnyNa0NtSC4S8
         8H07XojYRc6ej9rHupthclM4I5aPfdkQp5g/bHj11Sm3lO5YFOKtpxufBeZnFGimMnip
         xjMTlEJyyf1ZyLVZAWftBjjnSPqBcC4t5R7sBH1rxdWJ0xjLPiMqVu0mMMCMMq8jB9WH
         MKKMol/am9SdRvWS7kfUKrbLG5mj/kTG20yY6uLZCoCE/9A91ctj3lGAeJmhv7+hfd3i
         D7saZFDYQBV9iQ4Dz9HgAIlGmwYaXsBJaT06FD9YTewZMwfUAYazfJYNUusGnjaGnFS1
         UTlQ==
X-Gm-Message-State: ALoCoQn7x4YZlPJvgTV9gUCNnqaxg8JlMrD9et7zY5EcqhtgI0P6wpMW5O2236i0/Kj/a4bslTJc
X-Received: by 10.129.148.4 with SMTP id l4mr15288327ywg.142.1434649639897;
 Thu, 18 Jun 2015 10:47:19 -0700 (PDT)
Received: by 10.37.26.213 with HTTP; Thu, 18 Jun 2015 10:47:19 -0700 (PDT)
In-Reply-To: <1434626743-8552-5-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272031>

On Thu, Jun 18, 2015 at 4:25 AM, Paul Tan <pyokagan@gmail.com> wrote:
> +/**
> + * Reads the contents of `file`. The third argument can be used to give a hint

I would avoid `third` here. (I needed to count twice to be sure which
argument you
were referring to, as I was confused.) Also how do you abstain from
giving a hint?
(0 or negative or MAX_INT?)

So maybe

    /**
     * Reads the contents of `file`. Returns number of bytes read on success,
     * -1 if the file does not exist. If trim is set, trailing
whitespace will be removed
     * from the file contents. If `hint` is non-zero, it is used as a
hint for initial
     * allocation to avoid reallocs.
     */

> + * about the file size, to avoid reallocs. Returns number of bytes read on
> + * success, -1 if the file does not exist. If trim is set, trailing whitespace
> + * will be removed from the file contents.
> + */
> +static int read_state_file(struct strbuf *sb, const char *file, size_t hint, int trim)
> +{
> +       strbuf_reset(sb);
> +       if (strbuf_read_file(sb, file, hint) >= 0) {
> +               if (trim)
> +                       strbuf_trim(sb);
> +
> +               return sb->len;
> +       }
> +
> +       if (errno == ENOENT)
> +               return -1;
> +
> +       die_errno(_("could not read '%s'"), file);
> +}
> +
> +/**
> + * Loads state from disk.
> + */
> +static void am_load(struct am_state *state)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       read_state_file(&sb, am_path(state, "next"), 8, 1);
> +       state->cur = strtol(sb.buf, NULL, 10);
> +
> +       read_state_file(&sb, am_path(state, "last"), 8, 1);
> +       state->last = strtol(sb.buf, NULL, 10);
> +
> +       strbuf_release(&sb);
> +}
> +
> +/**
> + * Remove the am_state directory.
> + */
> +static void am_destroy(const struct am_state *state)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       strbuf_addstr(&sb, state->dir.buf);
> +       remove_dir_recursively(&sb, 0);
> +       strbuf_release(&sb);
> +}
> +
> +/**
> + * Setup a new am session for applying patches
> + */
> +static void am_setup(struct am_state *state)
> +{
> +       if (mkdir(state->dir.buf, 0777) < 0 && errno != EEXIST)
> +               die_errno(_("failed to create directory '%s'"), state->dir.buf);
> +
> +       write_file(am_path(state, "next"), 1, "%d", state->cur);
> +
> +       write_file(am_path(state, "last"), 1, "%d", state->last);
> +}
> +
> +/**
> + * Increments the patch pointer, and cleans am_state for the application of the
> + * next patch.
> + */
> +static void am_next(struct am_state *state)
> +{
> +       state->cur++;
> +       write_file(am_path(state, "next"), 1, "%d", state->cur);
> +}
> +
> +/**
> + * Applies all queued patches.
> + */
> +static void am_run(struct am_state *state)
> +{
> +       while (state->cur <= state->last) {
> +
> +               /* TODO: Patch application not implemented yet */
> +
> +               am_next(state);
> +       }
> +
> +       am_destroy(state);
> +}
> +
> +static struct am_state state;
> +
> +static const char * const am_usage[] = {
> +       N_("git am [options] [(<mbox>|<Maildir>)...]"),
> +       NULL
> +};
> +
> +static struct option am_options[] = {
> +       OPT_END()
> +};
>
>  int cmd_am(int argc, const char **argv, const char *prefix)
>  {
> @@ -24,5 +176,21 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>                 setup_work_tree();
>         }
>
> +       git_config(git_default_config, NULL);
> +
> +       am_state_init(&state);
> +       strbuf_addstr(&state.dir, git_path("rebase-apply"));
> +
> +       argc = parse_options(argc, argv, prefix, am_options, am_usage, 0);
> +
> +       if (am_in_progress(&state))
> +               am_load(&state);
> +       else
> +               am_setup(&state);
> +
> +       am_run(&state);
> +
> +       am_state_release(&state);
> +
>         return 0;
>  }
> --
> 2.1.4
>
