From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/6] bisect--helper: `bisect_clean_state` shell
 function in C
Date: Wed, 15 Jun 2016 14:04:12 -0400
Message-ID: <CAPig+cRfYS4FX+z4Yn-He_LctWdh7Ua56JU2HJs2C2+nTi5YyA@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-2-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 20:04:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDFAp-0001p3-Sk
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 20:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbcFOSEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 14:04:15 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34112 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbcFOSEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 14:04:14 -0400
Received: by mail-it0-f67.google.com with SMTP id d71so4359388ith.1
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 11:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=iet2TJoPF2q1JHZuvlMEFra2UMmpDhLNyWI6ctNS1+Y=;
        b=PXRr+8jHuRDGNTPWPpQ6yX8zxhYpCXcbi2lpdRJ3qa3HxhzDVa8lZWH59FQ7It1FLS
         4NVQLLxydVELT/M1HJKRrUtEbPCuCVuXcZ/aPrHrXWYkbQeSUQz9wapxgxJrNkVFiJrx
         qfWqKjpiA0bMwQjMmfrupug2prFa0AOalsD7FFWAfSFbazpra5B6r8pHHWS9uVXTWwBF
         swI5Pmm2mH1OHdnmmzsRVY0oadRD6eUDdew1+mu6oSMs+CNkNQzfQiJ5dp1ZcwzHdFPn
         orODZhfBQWObi5MvMZsU8P1Mjhtp8wRfRYJOzUxvt0++M9+C/x1sO1u18K11I8KKX5UH
         1N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=iet2TJoPF2q1JHZuvlMEFra2UMmpDhLNyWI6ctNS1+Y=;
        b=FZ1+PQEJwgTkr/ydxJ+Hp6Xc1EaO9csQx9LYS/sEG/T+BhLkTAjiouEYdo3mu857A8
         10MneW52037HJY7W4T/VaSSw7t0AMuWDbJOf5sVX2YRwRpr6ycIpgFrTO9TacI7YoI1Q
         nRSkzBGzmpx6Qmzxwl2xWKP4UCRQ14qT80+bsOsNuTiM6hEY0R6V9bVIhj9KMs8zgOJE
         fBDx538uK9eN0dc1FWya9Z68vk88qo64pdOeeU4ZjKht2lGo9vj/Sshq1TcQKHSrYDMO
         nkl2R8iAAAB+hjCEMQoHFnKFhxZKC6aDeyBDbXdf8+Jp435wefQNNEIAm+sAGtwJhTwi
         Sdvg==
X-Gm-Message-State: ALyK8tLOUTJ09eE6tz8Y/kNq7s/y0j20eYWOX3q+aKF6eex36FJpvPYvC5IT1EpLCS3Jdwy+o9DnQyGrRge6zA==
X-Received: by 10.36.55.15 with SMTP id r15mr1150347itr.73.1466013853246; Wed,
 15 Jun 2016 11:04:13 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 15 Jun 2016 11:04:12 -0700 (PDT)
In-Reply-To: <20160615140026.10519-2-pranit.bauva@gmail.com>
X-Google-Sender-Auth: MSIjrEA-G3KlLDmuq_Tagl9oExQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297382>

On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Reimplement `bisect_clean_state` shell function in C and add a
> `bisect-clean-state` subcommand to `git bisect--helper` to call it from
> git-bisect.sh .
> [...]
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> +static int mark_for_removal(const char *refname, const struct object_id *oid,
> +                           int flag, void *cb_data)
> +{
> +       struct string_list *refs = cb_data;
> +       char *ref = xstrfmt("refs/bisect/%s", refname);
> +       string_list_append(refs, ref);
> +       return 0;
> +}
> +
> +static int bisect_clean_state(void)
> +{
> +       int result = 0;
> +
> +       /* There may be some refs packed during bisection */
> +       struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
> +       for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
> +       string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
> +       result = delete_refs(&refs_for_removal);
> +       string_list_clear(&refs_for_removal, 0);

This is leaking all the strings added to 'refs_for_removal', isn't it?
Either you need to loop over the items and free the strings manually,
or (if it's not too ugly), set 'strdup_strings' before invoking
string_list_clear().

> +       remove_path(git_path_bisect_expected_rev());
> +       remove_path(git_path_bisect_ancestors_ok());
> +       remove_path(git_path_bisect_log());
> +       remove_path(git_path_bisect_names());
> +       remove_path(git_path_bisect_run());
> +       remove_path(git_path_bisect_write_terms());
> +       /* Cleanup head-name if it got left by an old version of git-bisect */
> +       remove_path(git_path_head_name());
> +       /*
> +        * Cleanup BISECT_START last to support the --no-checkout option
> +        * introduced in the commit 4796e823a.
> +        */
> +       remove_path(git_path_bisect_start());
> +
> +       return result;
> +}
