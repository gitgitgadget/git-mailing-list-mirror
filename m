From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [RFC PATCHv4] repack: rewrite the shell script in C.
Date: Tue, 20 Aug 2013 17:08:54 +0200
Message-ID: <52138686.1070304@googlemail.com>
References: <1376864786-21367-1-git-send-email-stefanbeller@googlemail.com> <1376954619-24314-1-git-send-email-stefanbeller@googlemail.com> <52136F9C.6030308@kdbg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6EB502F7271FDD1C1B265B4E"
Cc: git@vger.kernel.org, l.s.r@web.de, mfick@codeaurora.org,
	apelisse@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	pclouds@gmail.com, iveqy@iveqy.com, gitster@pobox.com,
	mackyle@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Aug 20 17:09:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBnYP-000896-8E
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 17:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252Ab3HTPJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 11:09:00 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:45938 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab3HTPI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 11:08:59 -0400
Received: by mail-ee0-f41.google.com with SMTP id d17so267614eek.14
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=RcKWs9r9K/IjO6rjFU+dl9bg1tfu81s3kqx2M2EapLI=;
        b=kMFfgHhZbgJJ7GB1t0xWRTxvqesqSPBLajItKi7WnuZblb86dvGueUrtKqhBwQKLBv
         2+8cbA8ecVsNUSp2EzGmtPUCP0El4SuHSJEPRM1pY76PMOKtvGnMIs/4jh7FDZ3lJe5n
         mA3o5QP4Kie3daRv5Vwcp9hO2/+Nax0qZH24tdvNQe5WkK0w07I4qJDi8co5vPtdOe9B
         NSfJw2DlJ7sukFKN0wX5K7c8kFPGZbFld4cCUwFkXjk9iUtp1+Iwprlftt7EY/mz3757
         bGel4zLmk0EffL6U8DY3Io1422IGm73s+k8rvHuUU/BQ1DewEb8CMufwKvGxQVwXPWiR
         xRiw==
X-Received: by 10.14.1.131 with SMTP id 3mr2938720eed.57.1377011338512;
        Tue, 20 Aug 2013 08:08:58 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id t6sm2997197eel.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 08:08:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <52136F9C.6030308@kdbg.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232609>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6EB502F7271FDD1C1B265B4E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/20/2013 03:31 PM, Johannes Sixt wrote:
>=20
> Are the long forms of options your invention?

I tried to keep strong similarity with the shell script for
ease of review. In the shellscript the options where=20
put in variables having these names, so for example there was:

	-f)	no_reuse=3D--no-reuse-delta ;;
	-F)	no_reuse=3D--no-reuse-object ;;

So I used these variable names as well in here. And as I assumed
the variables are meaningful in itself.

In the shell script they may be meaningful, but with the option
parser in the C version, I overlooked the possibility for=20
--no-<option> being possible as you noted below.

Maybe we should inverse the logic and have the variables and options
called reuse-delta and being enabled by default.

>=20
>> +        OPT_BOOL('a', "all", &pack_everything,
>> +                N_("pack everything in a single pack")),
>> +        OPT_BOOL('A', "all-but-loose", &pack_everything_but_loose,
>> +                N_("same as -a, and turn unreachable objects loose"))=
,
>=20
> --all-but-loose does not express what the help text says. The long form=

> of -A is --all --unpack-unreachable, so it is really just a short optio=
n
> for convenience. It does not need its own long form.

Ok, I'll keep that in mind, and will only use the varialbe tied to -A
to set the -a and --unpack-unreachable variable.

>=20
>> +        OPT_BOOL('d', "delete-redundant", &delete_redundant,
>> +                N_("remove redundant packs, and run git-prune-packed"=
)),
>> +        OPT_BOOL('f', "no-reuse-delta", &no_reuse_delta,
>> +                N_("pass --no-reuse-delta to git-pack-objects")),
>> +        OPT_BOOL('F', "no-reuse-object", &no_reuse_object,
>> +                N_("pass --no-reuse-object to git-pack-objects")),
>=20
> Do we want to allow --no-no-reuse-delta and --no-no-reuse-object?

see above, I'd try not to.

>=20
>> +        OPT_BOOL('n', NULL, &no_update_server_info,
>> +                N_("do not run git-update-server-info")),
>=20
> No long option name?

This is also a negated option, so as above, maybe=20
we could have --update_server_info and --no-update_server_info
respectively. Talking about the shortform then: Is it possible to
negate the shortform?

>=20
>> +        OPT__QUIET(&quiet, N_("be quiet")),
>> +        OPT_BOOL('l', "local", &local,
>> +                N_("pass --local to git-pack-objects")),
>=20
> Good.
>=20
>> +        OPT_STRING(0, "unpack-unreachable", &unpack_unreachable,
>> N_("approxidate"),
>> +                N_("with -A, do not loosen objects older than this
>> Packing constraints")),
>=20
> "Packing constraints" is a section heading, not a continuation of the
> previous help text.
>=20
>> +        OPT_INTEGER(0, "window", &window,
>> +                N_("size of the window used for delta compression")),=

>=20
> This help text is suboptimal as the option is a count, not a "size" in
> the narrow sense. But that can be changed later (as it would affect
> other tools as well, I guess).
>=20
>> +        OPT_INTEGER(0, "window-memory", &window_memory,
>> +                N_("same as the above, but limit memory size instead
>> of entries count")),
>> +        OPT_INTEGER(0, "depth", &depth,
>> +                N_("limits the maximum delta depth")),
>> +        OPT_INTEGER(0, "max-pack-size", &max_pack_size,
>> +                N_("maximum size of each packfile")),
>> +        OPT_END()
>> +    };
>=20
> Good.
>=20
>> +
>> +    git_config(repack_config, NULL);
>> +
>> +    argc =3D parse_options(argc, argv, prefix, builtin_repack_options=
,
>> +                git_repack_usage, 0);
>> +
>> +    sigchain_push_common(remove_pack_on_signal);
>=20
> Good.
>=20
>> +    packdir =3D mkpathdup("%s/pack", get_object_directory());
>> +    packtmp =3D mkpathdup("%s/.tmp-%d-pack", packdir, getpid());
>=20
> Should this not be
>=20
>     packdir =3D xstrdup(git_path("pack"));
>     packtmp =3D xstrdup(git_path("pack/.tmp-%d-pack", getpid()));
>=20
> Perhaps make packdir and packtmp global so that the strings need not be=

> duplicated in get_pack_filenames and remove_temporary_files?

ok

>=20
>> +
>> +    remove_temporary_files();
>=20
> Yes, the shell script had this. But is it really necessary?

Well I can drop it if it's not needed.
It actually should implement
	rm -f "$PACKTMP"-*
and then the trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15
as well.

>=20
>> +
>> +    struct argv_array cmd_args =3D ARGV_ARRAY_INIT;
>=20
> Declaration after statement.

will fix.

>=20
>> +    argv_array_push(&cmd_args, "pack-objects");
>> +    argv_array_push(&cmd_args, "--keep-true-parents");
>> +    argv_array_push(&cmd_args, "--honor-pack-keep");
>> +    argv_array_push(&cmd_args, "--non-empty");
>> +    argv_array_push(&cmd_args, "--all");
>> +    argv_array_push(&cmd_args, "--reflog");
>> +
>> +    if (window)
>> +        argv_array_pushf(&cmd_args, "--window=3D%u", window);
>> +
>> +    if (window_memory)
>> +        argv_array_pushf(&cmd_args, "--window-memory=3D%u",
>> window_memory);
>> +
>> +    if (depth)
>> +        argv_array_pushf(&cmd_args, "--depth=3D%u", depth);
>> +
>> +    if (max_pack_size)
>> +        argv_array_pushf(&cmd_args, "--max_pack_size=3D%u",
>> max_pack_size);
>> +
>> +    if (no_reuse_delta)
>> +        argv_array_pushf(&cmd_args, "--no-reuse-delta");
>> +
>> +    if (no_reuse_object)
>> +        argv_array_pushf(&cmd_args, "--no-reuse-object");
>=20
> no_reuse_delta and no_reuse_object are mutually exclusive, according to=

> the shell script version.

I'll change it then to OPT_BIT and die() when both are set.

>=20
>> +
>> +    if (pack_everything + pack_everything_but_loose =3D=3D 0) {
>> +        argv_array_push(&cmd_args, "--unpacked");
>> +        argv_array_push(&cmd_args, "--incremental");
>> +    } else {
>> +        struct string_list fname_list =3D STRING_LIST_INIT_DUP;
>> +        get_pack_filenames(packdir, &fname_list);
>> +        for_each_string_list_item(item, &fname_list) {
>> +            char *fname;
>> +            fname =3D mkpathdup("%s/%s.keep", packdir, item->string);=

>> +            if (stat(fname, &statbuffer) &&
>> S_ISREG(statbuffer.st_mode)) {
>=20
>             if (!stat(fname, &statbuffer) && ...
>=20
> But you are using file_exists() later. That should be good enough here
> as well, no?

will do.

>=20
>> +                /* when the keep file is there, we're ignoring that
>> pack */
>> +            } else {
>> +                string_list_append(&existing_packs, item->string);
>> +            }
>> +            free(fname);
>> +        }
>> +
>> +        if (existing_packs.nr && delete_redundant) {
>> +            if (unpack_unreachable)
>> +                argv_array_pushf(&cmd_args,
>> "--unpack-unreachable=3D%s", unpack_unreachable);
>> +            else if (pack_everything_but_loose)
>> +                argv_array_push(&cmd_args, "--unpack-unreachable");
>> +        }
>> +    }
>> +
>> +    if (local)
>> +        argv_array_push(&cmd_args,  "--local");
>> +    if (quiet)
>> +        argv_array_push(&cmd_args,  "--quiet");
>> +    if (delta_base_offset)
>> +        argv_array_push(&cmd_args,  "--delta-base-offset");
>> +
>> +    argv_array_push(&cmd_args, packtmp);
>=20
> Otherwise, argument setup looks fine.
>=20
>> +
>> +    memset(&cmd, 0, sizeof(cmd));
>> +    cmd.argv =3D argv_array_detach(&cmd_args, NULL);
>=20
> Is it necessary to detach the arguments?

Probably not.=20

>=20
>> +    cmd.git_cmd =3D 1;
>> +    cmd.out =3D -1;
>> +    cmd.no_stdin =3D 1;
>> +
>> +    if (run_command(&cmd))
>> +        return 1;
>=20
> You cannot run_command() and then later read its output! You must split=

> it into start_command(), read stdout, finish_command().

Thanks for this hint. Could that explain rare non-deterministic failures =
in
the test suite?

>=20
>> +
>> +    struct string_list names =3D STRING_LIST_INIT_DUP;
>> +    struct string_list rollback =3D STRING_LIST_INIT_DUP;
>=20
> Declaration after statement.

will fix
>=20
>> +
>> +    char line[1024];
>> +    int counter =3D 0;
>> +    FILE *out =3D xfdopen(cmd.out, "r");
>> +    while (fgets(line, sizeof(line), out)) {
>> +        /* a line consists of 40 hex chars + '\n' */
>> +        assert(strlen(line) =3D=3D 41);
>=20
> You cannot make assertions about input that you read from an external
> command! You can die() if the expectation is not met. But I think that
> in this case the only necessary expectation is that a line is not empty=
=2E
>=20
> BTW, don't we have strbuf functions to read from an fd linewise?

I'll check.

>=20
>> +        line[40] =3D '\0';
>> +        string_list_append(&names, line);
>> +        counter++;
>> +    }
>> +    if (!counter)
>> +        printf("Nothing new to pack.\n");
>=20
> This was 'say Nothing new to pack.'. say obeys --quiet, IIRC.

ok
>=20
>> +    fclose(out);
>> +
>> +    int failed =3D 0;
>> +    for_each_string_list_item(item, &names) {
>> +        for (ext =3D 0; ext < 1; ext++) {
>> +            char *fname, *fname_old;
>> +            fname =3D mkpathdup("%s/%s%s", packdir, item->string,
>> exts[ext]);
>> +            if (!file_exists(fname)) {
>> +                free(fname);
>> +                continue;
>> +            }
>> +
>> +            fname_old =3D mkpathdup("%s/old-%s%s", packdir,
>> item->string, exts[ext]);
>=20
> If you could use git_path() instead of mkpathdup() in these two cases,
> we would not need to free() the names.
>=20
>> +            if (file_exists(fname_old))
>> +                unlink(fname_old);
>> +
>> +            if (rename(fname, fname_old)) {
>> +                failed =3D 1;
>> +                break;
>> +            }
>> +            free(fname_old);
>> +            string_list_append_nodup(&rollback, fname);
>=20
> Ah, we would need to allocate here then.
>=20
>> +        }
>> +        if (failed)
>> +            /* set to last element to break for_each loop */
>> +            item =3D names.items + names.nr;
>=20
> A mere
>             break;
> doesn't do it here?

Sure! I'll replace by break.

>=20
>> +    }
>> +    if (failed) {
>> +        struct string_list rollback_failure;
>> +        for_each_string_list_item(item, &rollback) {
>> +            char *fname, *fname_old;
>> +            fname =3D mkpathdup("%s/%s", packdir, item->string);
>> +            fname_old =3D mkpathdup("%s/old-%s", packdir, item->strin=
g);
>=20
> I think it's possible to attach arbitrary data to each string_list item=
=2E
> We could attach the "%s/old-%s" name to the item name, then we wouldn't=

> need to re-construct the names here.

handy! I'll try to do that.

>=20
>> +            if (rename(fname_old, fname))
>> +                string_list_append(&rollback_failure, fname);
>> +            free(fname);
>> +            free(fname_old);
>> +        }
>> +
>> +        if (rollback.nr) {
>> +            int i;
>> +            fprintf(stderr,
>> +                "WARNING: Some packs in use have been renamed by\n"
>> +                "WARNING: prefixing old- to their name, in order to\n=
"
>> +                "WARNING: replace them with the new version of the\n"=

>> +                "WARNING: file.  But the operation failed, and the\n"=

>> +                "WARNING: attempt to rename them back to their\n"
>> +                "WARNING: original names also failed.\n"
>> +                "WARNING: Please rename them in $PACKDIR manually:\n"=
);
>> +            for (i =3D 0; i < rollback.nr; i++)
>> +                fprintf(stderr, "WARNING:   old-%s -> %s\n",
>> +                    rollback.items[i].string,
>> +                    rollback.items[i].string);
>> +        }
>> +        exit(1);
>> +    }
>> +
>> +    /* Now the ones with the same name are out of the way... */
>> +    for_each_string_list_item(item, &names) {
>> +        for (ext =3D 0; ext < 2; ext++) {
>> +            char *fname, *fname_old;
>> +            fname =3D mkpathdup("%s/pack-%s%s", packdir, item->string=
,
>> exts[ext]);
>> +            fname_old =3D mkpathdup("%s-%s%s", packtmp, item->string,=

>> exts[ext]);
>=20
> Same here: git_path()?
>=20
>> +            stat(fname_old, &statbuffer);
>=20
> We ignore errors during chmod in the shell script. But this doesn't giv=
e
> you license to ignore stat() errors completely: If stat() fails, then
> don't chmod() below, either.

ok

>=20
>> +            statbuffer.st_mode &=3D ~S_IWUSR | ~S_IWGRP | ~S_IWOTH;
>=20
>             statbuffer.st_mode &=3D ~(S_IWUSR|S_IWGRP|S_IWOTH);
>=20
>> +            chmod(fname_old, statbuffer.st_mode);
>> +            if (rename(fname_old, fname))
>> +                die("Could not rename packfile: %s -> %s", fname_old,=

>> fname);
>=20
> Use die_errno() here.
>=20
>> +            free(fname);
>> +            free(fname_old);
>> +        }
>> +    }
>> +
>> +    /* Remove the "old-" files */
>> +    for_each_string_list_item(item, &names) {
>> +        char *fname;
>> +        fname =3D mkpathdup("%s/old-pack-%s.idx", packdir, item->stri=
ng);
>> +        if (remove_path(fname))
>> +            die("Could not remove file: %s", fname);
>=20
> die_errno() makes sense here, too.
>=20
>> +        free(fname);
>> +
>> +        fname =3D mkpathdup("%s/old-pack-%s.pack", packdir, item->str=
ing);
>> +        if (remove_path(fname))
>> +            die("Could not remove file: %s", fname);
>=20
> and here as well.
>=20
>> +        free(fname);
>=20
> Again git_path?
>=20
>> +    }
>> +
>> +    /* End of pack replacement. */
>=20
> Nit: A blank line should follow this comment.
>=20
>> +    if (delete_redundant) {
>> +        sort_string_list(&names);
>> +        for_each_string_list_item(item, &existing_packs) {
>> +            char *sha1;
>> +            size_t len =3D strlen(item->string);
>> +            if (len < 40)
>> +                continue;
>> +            sha1 =3D item->string + len - 40;
>> +            if (!string_list_has_string(&names, sha1))
>> +                remove_pack(packdir, item->string);
>> +        }
>=20
> OK.
>=20
>> +        argv_array_clear(&cmd_args);
>> +        argv_array_push(&cmd_args, "prune-packed");
>> +        if (quiet)
>> +            argv_array_push(&cmd_args, "--quiet");
>> +
>> +        memset(&cmd, 0, sizeof(cmd));
>> +        cmd.argv =3D argv_array_detach(&cmd_args, NULL);
>=20
> Again: is it necessary to detach?
>=20
>> +        cmd.git_cmd =3D 1;
>> +        run_command(&cmd);
>> +    }
>> +
>> +    if (!no_update_server_info) {
>> +        argv_array_clear(&cmd_args);
>> +        argv_array_push(&cmd_args, "update-server-info");
>> +
>> +        memset(&cmd, 0, sizeof(cmd));
>> +        cmd.argv =3D argv_array_detach(&cmd_args, NULL);
>=20
> Same here?
>=20
>> +        cmd.git_cmd =3D 1;
>> +        run_command(&cmd);
>> +    }
>> +    return 0;
>> +}
>=20
> In my opinion, it is good that you keep a large function that resembles=

> the structure of the shell script because it is easier to review. But
> ultimately, it should be factored into smaller functions.
>=20
> -- Hannes
>=20

Hannes,

thank you very much for the review. I'll follow your suggestions and dive=

deeper into the API to change your annotated lines.

Thanks,
Stefan




--------------enig6EB502F7271FDD1C1B265B4E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSE4aGAAoJEJQCPTzLflhqxcMQAIHiUkD2wltK6x00AStGVxqO
DUGoiE0356X8m1xQARmeADlq31WyxeeBeBXQEM8FECVcu6bzRwaDsWZXdrKXrmj4
1rgZ1G9ovsi13d5olQqJS+pkyrXTuQeVegog2+NjfWANtR76sHo/Qxpb2VmIqmvz
xmbEZMiXWKMUjk/BnC9VjysEeTWtGs3WKqrUjKOWLlyYLhtjX7aUNVhGihLA2ufS
BSqEIXvBmxhvlTB4ud7rNBHXeq3zSIbClvvHrUj0CeD+U2kdiypdGA4h591Nphhf
40kSi2SCkNUTMBzKBRi+nsImUTkMOjeGSqETcH6pp4deOQ69EEdMJ8ya7u3eXZEe
N/cZnE6BCnGZfdOUKaQNtfJPCdMY2rs3YfynMYP3DEroUmyaNuoDk2yo46EVazcl
E7EpyF3SGS+EAcsTxGyodPdZckXf/bhibCghd/elS1Z33uweeC65fdSWbzm7Mo4p
C/fDCm6A8qaOquiEyGzB5Qq6eVNnkDFjREnfOuVhb3Ziuz5S0Anpn8QZBGqXPjaW
TIsyBo1lswGPc/2/XLFjXhpiYV+hdn8JYDnKweb4KafCky+y+4pB6s8nEy29GNa+
IKtywwcIcaLgSTZunIlqCXGwhP7m34tEidYADXNgbQbXKBZcL/iMTjxZbSvXdna6
4bCbnh/cZb3klsJMs3np
=/MLw
-----END PGP SIGNATURE-----

--------------enig6EB502F7271FDD1C1B265B4E--
