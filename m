From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCHv19 09/11] git submodule update: have a dedicated helper
 for cloning
Date: Sat, 27 Feb 2016 15:40:41 +0700
Message-ID: <CACsJy8DmhJrUkp=d4kSst=0yGWn+Hk=MqxCmhH3WqfPzhTt+Uw@mail.gmail.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
 <1456444119-6934-1-git-send-email-sbeller@google.com> <1456444119-6934-10-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 09:41:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZaRB-0000xA-2c
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 09:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbcB0IlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 03:41:13 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34291 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbcB0IlM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 03:41:12 -0500
Received: by mail-lb0-f171.google.com with SMTP id of3so57676904lbc.1
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 00:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0gkK2faQux5sp4tlsRvkhHH0Tg+CHqsjmGL08Kjk5H4=;
        b=LTcjDzx27BaS0IcKP+FLTi0Bi93y51O0voXT4RNX6Ym9YvxeMSNHeprNs5+d1piPYO
         ITkAdDINIbw+3UwuPoYjutVv3j+vp1RpLdbmDFaXRfbDM+nmv2nbm0Lo6h9cr8B6Smpv
         e7LndvNdqgCIvcZI4WrlsG1Jt+K4p/beQF+wuWyT8eO5bOdrnZLulbxJdYIf6MpWBAjD
         g3uS1++4LEllmzlS6wNqBanXrXBuOM0+cMOKns4KK3amfhDzanOl5Vbcw5th2vBkTnO8
         yBSGFFXmud3pKkEWY7jiQK97E6AwMOeSf+O2ibpR+o1XacWiMq99q2zs5BJEt0UWex2y
         Ephw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0gkK2faQux5sp4tlsRvkhHH0Tg+CHqsjmGL08Kjk5H4=;
        b=VCHd+FaCxzQ7Pw+5o2oFYYBSLmavnnmUgYC3kwsNkxsZSa/gNVknFaA3aWgkmaiHWL
         HNu4swSEt1Iknfq3RHslJSSOqkkbmlz69naHaoqcq2lER/AZWPffCNn2NUqcu13082R8
         arzoRZ5fLZpMBDUI5XOCMFJdg4yWvKkofZmhXVcNWTsqfYTG/emdetI9Pbq+wGRjwd2M
         lsounofqVlEvidbgZMCie/j6H3qO1mx/mQ+5xExH6eGpbvd6Ag4Z68tJG29wbr/xm1hd
         GHmRyWqk7pkRD/ir1inash+3lQDBMafFoFwj28IrhYd3paJxE0MmKLGNGZlEMXUt4I8Q
         f4nA==
X-Gm-Message-State: AD7BkJIJK4RIixt003cGEnB1a2iyAZ1+gtcQbJjKr5xedwIoiIMJei8aNTubaJ9/VNhMROq+Ua6/qYv8uJv3Pw==
X-Received: by 10.112.166.68 with SMTP id ze4mr2049386lbb.137.1456562470595;
 Sat, 27 Feb 2016 00:41:10 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sat, 27 Feb 2016 00:40:41 -0800 (PST)
In-Reply-To: <1456444119-6934-10-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287689>

On Fri, Feb 26, 2016 at 6:48 AM, Stefan Beller <sbeller@google.com> wrote:
> +static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
> +                                          struct child_process *child,
> +                                          struct submodule_update_clone *suc,
> +                                          struct strbuf *out)
> +{
> +       const struct submodule *sub = NULL;
> +       struct strbuf displaypath_sb = STRBUF_INIT;
> +       struct strbuf sb = STRBUF_INIT;
> +       const char *displaypath = NULL;
> +       char *url = NULL;
> +       int needs_cloning = 0;
> +
> +       if (ce_stage(ce)) {
> +               if (suc->recursive_prefix) {
> +                       strbuf_addf(out, "Skipping unmerged submodule %s/%s\n",
> +                                   suc->recursive_prefix, ce->name);

I'm pretty sure this string is for human consumption (because it's
_()'d elsehwere in this function), please _() this string.

> +               } else {
> +                       strbuf_addf(out, "Skipping unmerged submodule %s\n",
> +                                   ce->name);

and this one

> +               }
> +               goto cleanup;
> +       }
> +
> +       sub = submodule_from_path(null_sha1, ce->name);
> +
> +       if (suc->recursive_prefix)
> +               displaypath = relative_path(suc->recursive_prefix,
> +                                           ce->name, &displaypath_sb);
> +       else
> +               displaypath = ce->name;
> +
> +       if (suc->update.type == SM_UPDATE_NONE
> +           || (suc->update.type == SM_UPDATE_UNSPECIFIED
> +               && sub->update_strategy.type == SM_UPDATE_NONE)) {
> +               strbuf_addf(out, "Skipping submodule '%s'\n",
> +                           displaypath);

and this one

> +               goto cleanup;
> +       }
> +
> +       /*
> +        * Looking up the url in .git/config.
> +        * We must not fall back to .gitmodules as we only want
> +        * to process configured submodules.
> +        */
> +       strbuf_reset(&sb);
> +       strbuf_addf(&sb, "submodule.%s.url", sub->name);
> +       git_config_get_string(sb.buf, &url);
> +       if (!url) {
> +               /*
> +                * Only mention uninitialized submodules when their
> +                * path have been specified
> +                */
> +               if (suc->warn_if_uninitialized)
> +                       strbuf_addf(out, _("Submodule path '%s' not initialized\n"
> +                                   "Maybe you want to use 'update --init'?\n"),
> +                                   displaypath);

oh it's already marked :)

BTW, while you're editing this file, perhaps do this too (maybe in a
separate patch)? Because die() already prepends "fatal:"

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a6e54fa..6cf47de 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -731,13 +731,13 @@ int cmd_submodule__helper(int argc, const char
**argv, const char *prefix)
 {
        int i;
        if (argc < 2)
-               die(_("fatal: submodule--helper subcommand must be "
+               die(_("submodule--helper subcommand must be "
                      "called with a subcommand"));

        for (i = 0; i < ARRAY_SIZE(commands); i++)
                if (!strcmp(argv[1], commands[i].cmd))
                        return commands[i].fn(argc - 1, argv + 1, prefix);

-       die(_("fatal: '%s' is not a valid submodule--helper "
+       die(_("'%s' is not a valid submodule--helper "
              "subcommand"), argv[1]);
 }
-- 
Duy
