Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E150A1F859
	for <e@80x24.org>; Sat, 10 Sep 2016 16:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755564AbcIJQlT (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 12:41:19 -0400
Received: from mout.web.de ([212.227.15.4]:56635 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755179AbcIJQlS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 12:41:18 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0Ls9JH-1b2rZ60Xct-013wBw; Sat, 10 Sep 2016 18:40:59
 +0200
Date:   Sat, 10 Sep 2016 16:40:57 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        sbeller@google.com, Johannes.Schindelin@gmx.de, jnareb@gmail.com,
        mlbright@gmail.com, jacob.keller@gmail.com
Subject: Re: [PATCH v7 10/10] convert: add filter.<driver>.process option
Message-ID: <20160910164056.GA14646@tb-raspi>
References: <20160908182132.50788-1-larsxschneider@gmail.com>
 <20160908182132.50788-11-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160908182132.50788-11-larsxschneider@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:hag8wK5HWqPDLQFRMcO31kNZwnKIOUwUpzMgGAp+v07cMci7WXN
 NvwzM98Yoz5oMiopAHqKCMyETKFomoiRPw/qepTecuxPqoCkJSY1mCCWwXHdjNA33QRXTE6
 cZJsptxDQnZPhNARLYNvSGx4Hl37ELP3iaQeHDlX2R9/TbU7eblf3dub6BL8KTKYx9d0a6Y
 T81wFpir/rxes8q71/qTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U4fc0m/Vt10=:H3aloGH4NJHKjpPfJixRjE
 gnwEce8RXLOlVMjG+2L9Z7/2E84owonWI25T3+Nf+MZOzUWt8nXWVGD+VKtja5XdTbSSp9dbS
 o1lpjGXPDG9j93fOm+PoitHJaJ5dxtaId0Iy6Vs2agvwtc0AeinPVYOub1ZxFhjUQ2m6gTDSV
 rtalEdNtH+Na7gFyRT1fmvDiIU2j7zPodkHmjmZoVdSBMWw8dk0P2tf4Xb+tnWTj0gkWRC9WI
 xLOhTVEa1SlnlYWeBd+OdMN/SNRisFQM41TcFQ6Jo9UYS1p/84jDDebCsVxlHSXcYDY91JtDE
 nAEEAVOACFGlh3jk4ZL15+GdH+rZk4uE5hNExsFHM65FgfnIOmX5BMC9Jn8T/xDbBc4QpeP9O
 ixcXRKy0wJiZlB9cYAh+FYHxlqqz+KTZSIS0ZkTMwTXzKhNo71CEtAOFyw5PSTi3zZHlE1jHl
 fE/P3CQrB6+NZCQ5abavBg3Hs88iR13Z2t+E9NbwIPJXcBpfs0OeNTql0EhslZ5XU5kO9RWBT
 PL6QHqebjRzCjPJkRJyaensaDCwHv3u/ACkEuxNu7LDfeNu+r/ZMaCXG1izrxEE8Pp06OjjyN
 VZLSZH1ZnfC21jjWmnal7qNQ49uTFmEi8Nz3FcVanTUwLGxgDxGiMue10coMgfCTjnMo0K4oO
 +nA/X0n9Z8CsBbLDA52TCJRuuQqOxLf0Druv4v26v7MUwkAfGU6Bqz/OJq7Vi1f1LE7KTbuf2
 X/cVwzuBFnCs+vQr3umlrU3oQ5LAyb2b+9XPJcQLo4omxV9aTzhvuyW8w3c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[]

One general question up here, more comments inline.
The current order for a clean-filter is like this, I removed the error handling:

int convert_to_git()
{
	ret |= apply_filter(path, src, len, -1, dst, filter);
	if (ret && dst) {
		src = dst->buf;
		len = dst->len;
	}
	ret |= crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe);
	return ret | ident_to_git(path, src, len, dst, ca.ident);
}

The first step is the clean filter, the CRLF-LF conversion (if needed),
then ident.
The current implementation streams the whole file content to the filter,
(STDIN of the filter) and reads back STDOUT from the filter into a STRBUF.
This is to use the UNIX-like STDIN--STDOUT method for writing a filter.

However, int would_convert_to_git_filter_fd() and convert_to_git_filter_fd()
offer a sort of short-cut:
The filter reads from the file directly, and the output of the filter is
read into a STRBUF.

It looks as if the multi-filter approach can use this in a similar way:
Give the pathname to the filter, the filter opens the file for reading
and stream the result via the pkt-line protocol into Git.
This needs some more changes, and may be very well go into a separate patch
series. (and should).

What I am asking for:
When a multi-filter is used, the content is handled to the filter via pkt-line,
and the result is given to Git via pkt-line ?
Nothing wrong with it, I just wonder, if it should be mentioned somewhere.

> diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-filter/example.pl
> new file mode 100755
> index 0000000..279fbfb
> --- /dev/null
> +++ b/contrib/long-running-filter/example.pl
> @@ -0,0 +1,111 @@
> +#!/usr/bin/perl
> +#
> +# Example implementation for the Git filter protocol version 2
> +# See Documentation/gitattributes.txt, section "Filter Protocol"
> +#
> +
> +use strict;
> +use warnings;
> +
> +my $MAX_PACKET_CONTENT_SIZE = 65516;
> +
> +sub packet_read {
> +    my $buffer;
> +    my $bytes_read = read STDIN, $buffer, 4;
> +    if ( $bytes_read == 0 ) {
> +
> +        # EOF - Git stopped talking to us!
> +        exit();
> +    }
> +    elsif ( $bytes_read != 4 ) {
> +        die "invalid packet size '$bytes_read' field";
> +    }

This is half-kosher, I would say,
(And I really. really would like to see an implementation in C ;-)

A read function may look like this:

   ret = read(0, &buffer, 4);
   if (ret < 0) {
     /* Error, nothing we can do */
     exit(1);
   } else if (ret == 0) {
     /* EOF  */
     exit(0);
   } else if (ret < 4) {
     /* 
      * Go and read more, until we have 4 bytes or EOF or Error */
   } else {
     /* Good case, see below */
   }

> +    my $pkt_size = hex($buffer);
> +    if ( $pkt_size == 0 ) {
> +        return ( 1, "" );
> +    }
> +    elsif ( $pkt_size > 4 ) {
> +        my $content_size = $pkt_size - 4;
> +        $bytes_read = read STDIN, $buffer, $content_size;
> +        if ( $bytes_read != $content_size ) {
> +            die "invalid packet ($content_size expected; $bytes_read read)";
> +        }
> +        return ( 0, $buffer );
> +    }
> +    else {
> +        die "invalid packet size";
> +    }
> +}
> +
> +sub packet_write {
> +    my ($packet) = @_;
> +    print STDOUT sprintf( "%04x", length($packet) + 4 );
> +    print STDOUT $packet;
> +    STDOUT->flush();
> +}
> +
> +sub packet_flush {
> +    print STDOUT sprintf( "%04x", 0 );
> +    STDOUT->flush();
> +}
> +
> +( packet_read() eq ( 0, "git-filter-client" ) ) || die "bad initialization";
> +( packet_read() eq ( 0, "version=2" ) )         || die "bad version";
> +( packet_read() eq ( 1, "" ) )                  || die "bad version end";
> +
> +packet_write("git-filter-server\n");
> +packet_write("version=2\n");
> +
> +( packet_read() eq ( 0, "clean=true" ) )  || die "bad capability";
> +( packet_read() eq ( 0, "smudge=true" ) ) || die "bad capability";
> +( packet_read() eq ( 1, "" ) )            || die "bad capability end";
> +
> +packet_write( "clean=true\n" );
> +packet_write( "smudge=true\n" );
> +packet_flush();
> +
> +while (1) {
> +    my ($command) = packet_read() =~ /^command=([^=]+)\n$/;
> +    my ($pathname) = packet_read() =~ /^pathname=([^=]+)\n$/;
> +
> +    packet_read();
> +
> +    my $input = "";
> +    {
> +        binmode(STDIN);
> +        my $buffer;
> +        my $done = 0;
> +        while ( !$done ) {
> +            ( $done, $buffer ) = packet_read();
> +            $input .= $buffer;
> +        }
> +    }
> +
> +    my $output;
> +    if ( $command eq "clean" ) {
> +        ### Perform clean here ###
> +        $output = $input;
> +    }
> +    elsif ( $command eq "smudge" ) {
> +        ### Perform smudge here ###
> +        $output = $input;
> +    }
> +    else {
> +        die "bad command '$command'";
> +    }
> +
> +    packet_write("status=success\n");
> +    packet_flush();
> +    while ( length($output) > 0 ) {
> +        my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
> +        packet_write($packet);
> +        if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
> +            $output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
> +        }
> +        else {
> +            $output = "";
> +        }
> +    }
> +    packet_flush(); # flush content!
> +    packet_flush(); # empty list!
> +}
> diff --git a/convert.c b/convert.c
> index a068df7..0ed48ed 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -3,6 +3,7 @@
>  #include "run-command.h"
>  #include "quote.h"
>  #include "sigchain.h"
> +#include "pkt-line.h"
>  
>  /*
>   * convert.c - convert a file when checking it out and checking it in.
> @@ -442,7 +443,7 @@ static int filter_buffer_or_fd(int in, int out, void *data)
>  	return (write_err || status);
>  }
>  
> -static int apply_filter(const char *path, const char *src, size_t len, int fd,
> +static int apply_single_file_filter(const char *path, const char *src, size_t len, int fd,
>                          struct strbuf *dst, const char *cmd)
>  {
>  	/*
> @@ -456,12 +457,6 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
>  	struct async async;
>  	struct filter_params params;
>  
> -	if (!cmd || !*cmd)
> -		return 0;
> -
> -	if (!dst)
> -		return 1;
> -
>  	memset(&async, 0, sizeof(async));
>  	async.proc = filter_buffer_or_fd;
>  	async.data = &params;
> @@ -496,14 +491,318 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
>  	return !err;
>  }
>  
> +#define CAP_CLEAN    (1u<<0)
> +#define CAP_SMUDGE   (1u<<1)

Is CAP_ too generic, and GIT_FILTER_CAP (or so) less calling for trouble ? 

> +
> +struct cmd2process {
> +	struct hashmap_entry ent; /* must be the first member! */
> +	int supported_capabilities;
> +	const char *cmd;
> +	struct child_process process;
> +};
> +
> +static int cmd_process_map_initialized;
> +static struct hashmap cmd_process_map;
> +
> +static int cmd2process_cmp(const struct cmd2process *e1,
> +                           const struct cmd2process *e2,
> +                           const void *unused)
> +{
> +	return strcmp(e1->cmd, e2->cmd);
> +}
> +
> +static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap, const char *cmd)
> +{
> +	struct cmd2process key;
> +	hashmap_entry_init(&key, strhash(cmd));
> +	key.cmd = cmd;
> +	return hashmap_get(hashmap, &key, NULL);
> +}
> +
> +static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *entry)
> +{
> +	if (!entry)
> +		return;
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	/*
> +	 * We kill the filter most likely because an error happened already.
> +	 * That's why we are not interested in any error code here.
> +	 */
> +	close(entry->process.in);
> +	close(entry->process.out);
> +	sigchain_pop(SIGPIPE);
> +	finish_command(&entry->process);
> +	hashmap_remove(hashmap, entry, NULL);
> +	free(entry);
> +}
> +
> +static int packet_write_list(int fd, const char *line, ...)
> +{
> +	va_list args;
> +	int err;
> +	va_start(args, line);
> +	for (;;)
> +	{
> +		if (!line)
> +			break;
> +		if (strlen(line) > PKTLINE_DATA_MAXLEN)
> +			return -1;
> +		err = packet_write_fmt_gently(fd, "%s", line);
> +		if (err)
> +			return err;
> +		line = va_arg(args, const char*);
> +	}
> +	va_end(args);
> +	return packet_flush_gently(fd);
> +}
> +
> +static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
> +{
> +	int err;
> +	struct cmd2process *entry;
> +	struct child_process *process;
> +	const char *argv[] = { cmd, NULL };
> +	struct string_list cap_list = STRING_LIST_INIT_NODUP;
> +	char *cap_buf;
> +	const char *cap_name;
> +
> +	entry = xmalloc(sizeof(*entry));
> +	hashmap_entry_init(entry, strhash(cmd));
> +	entry->cmd = cmd;
> +	entry->supported_capabilities = 0;
> +	process = &entry->process;
> +
> +	child_process_init(process);
> +	process->argv = argv;
> +	process->use_shell = 1;
> +	process->in = -1;
> +	process->out = -1;
> +
> +	if (start_command(process)) {
> +		error("cannot fork to run external filter '%s'", cmd);
> +		kill_multi_file_filter(hashmap, entry);
> +		return NULL;
> +	}
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
> +	err = packet_write_list(process->in, "git-filter-client", "version=2", NULL);
> +	if (err)
> +		goto done;
> +
> +	err = strcmp(packet_read_line(process->out, NULL), "git-filter-server");
> +	if (err) {
> +		error("external filter '%s' does not support long running filter protocol", cmd);
> +		goto done;
> +	}
> +	err = strcmp(packet_read_line(process->out, NULL), "version=2");
> +	if (err)
> +		goto done;
> +
> +	err = packet_write_list(process->in, "clean=true", "smudge=true", NULL);
> +
> +	for (;;)
> +	{
> +		cap_buf = packet_read_line(process->out, NULL);
> +		if (!cap_buf)
> +			break;
> +		string_list_split_in_place(&cap_list, cap_buf, '=', 1);
> +
> +		if (cap_list.nr != 2 || strcmp(cap_list.items[1].string, "true"))
> +			continue;
> +
> +		cap_name = cap_list.items[0].string;
> +		if (!strcmp(cap_name, "clean")) {
> +			entry->supported_capabilities |= CAP_CLEAN;
> +		} else if (!strcmp(cap_name, "smudge")) {
> +			entry->supported_capabilities |= CAP_SMUDGE;
> +		} else {
> +			warning(
> +				"external filter '%s' requested unsupported filter capability '%s'",
> +				cmd, cap_name
> +			);
> +		}
> +
> +		string_list_clear(&cap_list, 0);
> +	}
> +
> +done:
> +	sigchain_pop(SIGPIPE);
> +
> +	if (err || errno == EPIPE) {
> +		error("initialization for external filter '%s' failed", cmd);
> +		kill_multi_file_filter(hashmap, entry);
> +		return NULL;
> +	}
> +
> +	hashmap_add(hashmap, entry);
> +	return entry;
> +}
> +
> +static void read_multi_file_filter_values(int fd, struct strbuf *status) {
> +	struct strbuf **pair;
> +	char *line;
> +	for (;;) {
> +		line = packet_read_line(fd, NULL);
> +		if (!line)
> +			break;
> +		pair = strbuf_split_str(line, '=', 2);
> +		if (pair[0] && pair[0]->len && pair[1]) {
> +			if (!strcmp(pair[0]->buf, "status=")) {
> +				strbuf_reset(status);
> +				strbuf_addbuf(status, pair[1]);
> +			}
> +		}
> +	}
> +}
> +
> +static int apply_multi_file_filter(const char *path, const char *src, size_t len,
> +                                   int fd, struct strbuf *dst, const char *cmd,
> +                                   const int wanted_capability)
> +{
> +	int err;
> +	struct cmd2process *entry;
> +	struct child_process *process;
> +	struct stat file_stat;
> +	struct strbuf nbuf = STRBUF_INIT;
> +	struct strbuf filter_status = STRBUF_INIT;
> +	char *filter_type;
> +
> +	if (!cmd_process_map_initialized) {
> +		cmd_process_map_initialized = 1;
> +		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
> +		entry = NULL;
> +	} else {
> +		entry = find_multi_file_filter_entry(&cmd_process_map, cmd);
> +	}
> +
> +	fflush(NULL);
> +
> +	if (!entry) {
> +		entry = start_multi_file_filter(&cmd_process_map, cmd);
> +		if (!entry)
> +			return 0;
> +	}
> +	process = &entry->process;
> +
> +	if (!(wanted_capability & entry->supported_capabilities))
> +		return 0;
> +
> +	if (CAP_CLEAN & wanted_capability)
> +		filter_type = "clean";
> +	else if (CAP_SMUDGE & wanted_capability)
> +		filter_type = "smudge";
> +	else
> +		die("unexpected filter type");
> +
> +	if (fd >= 0 && !src) {
> +		if (fstat(fd, &file_stat) == -1)
> +			return 0;
> +		len = xsize_t(file_stat.st_size);
> +	}
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
> +
> +	err = (strlen(filter_type) > PKTLINE_DATA_MAXLEN);

Extra () needed ?
More () in the code...

No more comments today (except that the kill is overkill)
